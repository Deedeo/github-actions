variable "vpc_name" {
  type        = string
  description = "The name of the VPC"
  default     = "alt-school"
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "vpc_azs" {
  type        = list(string)
  description = "A list of availability zones for the VPC"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "vpc_private_subnets" {
  type        = list(string)
  description = "A list of CIDR blocks for the private subnets in the VPC"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "vpc_public_subnets" {
  type        = list(string)
  description = "A list of CIDR blocks for the public subnets in the VPC"
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "vpc_enable_nat_gateway" {
  type        = bool
  description = "Whether to enable NAT gateways in the VPC"
  default     = false
}

variable "vpc_enable_vpn_gateway" {
  type        = bool
  description = "Whether to enable VPN gateways in the VPC"
  default     = true
}

variable "aws_region" {
  type        = string
  description = "The AWS region to deploy the VPC into"
  default     = "us-east-1"
}
  

variable "vpc_tags" {
  type        = map(string)
  description = "A map of tags to apply to the VPC"
  default     = {
    Terraform    = "true"
    Environment  = "dev"
  }
}