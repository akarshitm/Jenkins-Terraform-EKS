locals {
  region        = "us-east-1"
  name          = "Natwest-cluster"
  vpc_cidr      = "172.31.0.0/16"
  azs           = ["us-east-1a", "us-east-1b"]
  public_subnets  = ["172.31.1.0/24", "172.31.2.0/24"]
  private_subnets = ["172.31.3.0/24", "172.31.4.0/24"]
  intra_subnets   = ["172.31.5.0/24", "172.31.6.0/24"]

  tags = {
    Example = local.name
  }
}

terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.67" # pin to v4 to avoid breaking changes in v5
    }
  }
}

provider "aws" {
  region = local.region
}
