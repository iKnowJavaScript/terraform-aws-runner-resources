data "aws_secretsmanager_secret_version" "gh_runner_secret" {
  secret_id = "gh-runner/${var.environment}"
}

locals {
  environment = var.environment != null ? var.environment : "dev"
  aws_region  = "us-east-1"
  prefix      = "bt-gh-runner"
}

resource "random_id" "random" {
  byte_length = 20
}

module "runners" {
  source  = "philips-labs/github-runner/aws"
  version = "5.3.0"

  aws_region = local.aws_region
  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  key_name = var.key_name

  prefix = local.prefix
  tags = {
    Project = "GitHub Runner"
  }

  github_app = {
    key_base64     = jsondecode(data.aws_secretsmanager_secret_version.gh_runner_secret.secret_string)["APP_PRIVATE_KEY_BASE_64"]
    id             = jsondecode(data.aws_secretsmanager_secret_version.gh_runner_secret.secret_string)["APP_ID"]
    webhook_secret = random_id.random.hex
  }

  # configure the block device mappings, default for Amazon Linux2
  block_device_mappings = [{
    device_name           = "/dev/xvda"
    delete_on_termination = true
    volume_type           = "gp3"
    volume_size           = 10
    encrypted             = true
    iops                  = null
  }]

  # This is downloaded from the lambda-download module will be access from this directory fo easy access
  webhook_lambda_zip                = "${path.cwd}/modules/lambdas-download/webhook.zip"
  runner_binaries_syncer_lambda_zip = "${path.cwd}/modules/lambdas-download/runner-binaries-syncer.zip"
  runners_lambda_zip                = "${path.cwd}/modules/lambdas-download/runners.zip"

  enable_organization_runners = true
  runner_extra_labels         = ["custom_with_webhook"]
  runner_os                   = "linux"
  runner_architecture         = "arm64"
  instance_types              = ["t4g.large", "t4g.medium"]
  # instance_types            = ["m5.large", "c5.large"]

  # enable access to the runners via SSM
  enable_ssm_on_runners = true

  # Let the module manage the service linked role
  create_service_linked_role_spot = true

  # override delay of events in seconds
  delay_webhook_event   = 5
  runners_maximum_count = 5

  # set up a fifo queue to remain order
  enable_fifo_build_queue = true

  # override scaling down
  scale_down_schedule_expression = "cron(* * * * ? *)"
  # enable this flag to publish webhook events to workflow job queue
  enable_workflow_job_events_queue = true

  enable_user_data_debug_logging_runner = true

  # prefix GitHub runners with the prefix name
  runner_name_prefix = "${local.prefix}_"

  # Enable debug logging for the lambda functions
  log_level = "debug"

  enable_ami_housekeeper = false
}

module "webhook_github_app" {
  source     = "philips-labs/github-runner/aws//modules/webhook-github-app"
  version    = "5.3.0"
  depends_on = [module.runners]

  github_app = {
    key_base64     = jsondecode(data.aws_secretsmanager_secret_version.gh_runner_secret.secret_string)["APP_PRIVATE_KEY_BASE_64"]
    id             = jsondecode(data.aws_secretsmanager_secret_version.gh_runner_secret.secret_string)["APP_ID"]
    webhook_secret = random_id.random.hex
  }
  webhook_endpoint = module.runners.webhook.endpoint
}
