terraform {
  required_version = ">= 1.15"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.56"
    }
  }
}

provider "aws" {
  region = "us-west-2"

  default_tags {
    tags = {
      env        = "dev"
      system     = "poc"
      created_by = "terraform"
    }
  }
}
