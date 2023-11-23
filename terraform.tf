terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.2"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket         = "startercc-terraform-state"
    key            = "automation/cicd-gh-runner/dev/us-east-1/terraform.tfstate"
    dynamodb_table = "dynamoDB-startercc-terraform-state-locking"
    region         = "us-east-1"
    encrypt        = true
  }
}

provider "aws" {
  region = local.aws_region

  default_tags {
    tags = {
      For  = "github-runner"
      Type = "CI/CD"
    }
  }
}
