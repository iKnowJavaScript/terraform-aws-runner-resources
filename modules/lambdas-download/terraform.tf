terraform {
  required_version = ">= 1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.2"
    }
  }

  backend "s3" {
    bucket         = "startercc-terraform-state"
    key            = "automation/cicd-gh-runner-module-s3/dev/us-east-1/terraform.tfstate"
    kms_key_id     = "alias/terraform-artifact-bucket-state-dev"
    dynamodb_table = "dynamoDB-startercc-terraform-state-locking"
    region         = "us-east-1"
    encrypt = true
  }
}
