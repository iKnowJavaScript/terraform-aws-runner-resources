# Wrapper module to download lambda's for running the bt-github-runner

Module is used to download Lambda distribution from the GitHub release.

```bash
terraform init
terraform apply
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambdas"></a> [lambdas](#module\_lambdas) | philips-labs/terraform-aws-github-runner/modules/download-lambda | 5.3.0 |

## Resources

No resources.


## Outputs

| Name | Description |
|------|-------------|
| <a name="output_files"></a> [files](#output\_files) | n/a |
<!-- END_TF_DOCS -->
