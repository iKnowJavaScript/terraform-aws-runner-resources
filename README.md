# Action runners deployment

This module shows how to create GitHub action runners. Lambda release will be downloaded from GitHub.

## Usages

Steps for the full setup, such as creating a GitHub app can be found in the root module's [README](https://github.com/philips-labs/terraform-aws-github-runner/blob/main/README.md). First download the Lambda releases from GitHub. Alternatively you can build the lambdas locally by running the lambda-download module, Kindly move the downloaded files from lambda-download folder to the this root directory and you might want to update the specify S3 bucket that also holds the binary too.

> Ensure you have set the version in `modules/lambdas-download/main.tf` for running the example. The version needs to be set to a GitHub release version, see https://github.com/philips-labs/terraform-aws-github-runner/releases

```bash
cd ../lambdas-download
terraform init
terraform apply
cd -
```

Before running Terraform, ensure the GitHub app is configured. See the [configuration details](https://github.com/philips-labs/terraform-aws-github-runner/blob/main/README.md#usages) for more details.

```bash
terraform init
terraform apply
```

The module will try to update the GitHub App webhook and secret (only linux/mac). You can receive the webhook details by running:

```bash
terraform output webhook_secret
terraform output -json webhook_secret
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.2 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~> 2.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_runners"></a> [runners](#module\_runners) | philips-labs/github-runner/aws | 5.3.0 |
| <a name="module_webhook_github_app"></a> [webhook\_github\_app](#module\_webhook\_github\_app) | philips-labs/github-runner/aws//modules/webhook-github-app | 5.3.0 |

## Resources

| Name | Type |
|------|------|
| [random_id.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name, used as prefix | `string` | `null` | no |
| <a name="input_github_app"></a> [github\_app](#input\_github\_app) | GitHub for API usages. | <pre>object({<br>    id         = string<br>    key_base64 = string<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_runners"></a> [runners](#output\_runners) | n/a |
| <a name="output_webhook_endpoint"></a> [webhook\_endpoint](#output\_webhook\_endpoint) | n/a |
| <a name="output_webhook_secret"></a> [webhook\_secret](#output\_webhook\_secret) | n/a |
<!-- END_TF_DOCS -->
