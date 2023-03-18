# locals {
#   environment_name = "alt-school"
#   tags = {
#     ops_env              = "${local.environment_name}"
#     ops_managed_by       = "github-actions",
#     ops_source_repo      = "kubernetes-ops",
#     ops_source_repo_path = "terraform-environments/aws/${local.environment_name}/10-vpc",
#     ops_owners           = "devops",
#   }
# }

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.37.0"
    }
  }
  backend "remote" {
    # Update to your Terraform Cloud organization
    organization = "Deebudapest"

    workspaces {
      name = "github-action-workspace"
    }
  }
}

# provider "aws" {
#   region = var.aws_region
# }


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway = var.vpc_enable_nat_gateway
  enable_vpn_gateway = var.vpc_enable_vpn_gateway

  tags = var.vpc_tags
}
