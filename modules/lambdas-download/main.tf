module "lambdas" {
  source  = "philips-labs/github-runner/aws//modules/download-lambda"
  version = "5.3.0"

  lambdas = [
    {
      name = "webhook"
      tag  = "v${var.module_version}"
    },
    {
      name = "runners"
      tag  = "v${var.module_version}"
    },
    {
      name = "runner-binaries-syncer"
      tag  = "v${var.module_version}"
    }
  ]
}

output "files" {
  value = module.lambdas.files
}
