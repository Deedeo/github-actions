# Description: EKS cluster configuration
locals {
  environment_name = "alt-school"
  tags = {
    ops_env              = "${local.environment_name}"
    ops_managed_by       = "github-actions",
    ops_source_repo      = "kubernetes-ops",
    ops_source_repo_path = "terraform-environments/aws/${local.environment_name}/20-eks",
    ops_owners           = "devops",
  }
}

# Configure the AWS Provider to use the region specified in the environment
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.37.0"
    }
    random = {
      source = "hashicorp/random"
    }
  }
  backend "remote" {
    # Update to your Terraform Cloud organization
    organization = "Deebudapest"

    workspaces {
      name = "github-action-eks-workspace"
    }
  }
}

# Configure the AWS Provider to use the region specified in the environment
provider "aws" {
  region = var.aws_region
}


# Data sources for remote state data  (VPC) 


data "terraform_remote_state" "vpc" {
  backend = "remote"
  config = {
    # Update to your Terraform Cloud organization
    organization = "Deebudapest"
    workspaces = {
      name = "github-action-workspace"
    }
  }
}

# EKS cluster configuration 
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.5.1"

  cluster_name    = local.environment_name
  cluster_version = "1.24"

  vpc_id                         = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids                     = data.terraform_remote_state.vpc.outputs.public_subnets
  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    ami_type = "AL2_ARM_64"

  }

eks_managed_node_groups = {
    one = {
      name        = "node-group-1"

      instance_types = ["t4g.2xlarge"]

      min_size     = 1
      max_size     = 6
      desired_size = 3
    }
}
}
