variable "cluster_endpoint_public_access" {
  type        = bool
  default     = true
  description = "Enable or disable Kube API public access"
}

variable "cluster_endpoint_private_access" {
  type        = bool
  default     = false
  description = "Enable or disable Kube API private access"
}


variable "cluster_endpoint_public_access_cidrs" {
  type = list(any)
  default = [
    "0.0.0.0/0", "1.1.1.1/32",
  ]
  description = "Kube API public endpoint allow access cidrs"
}


variable "ami_type" {
  type        = string
  default     = "AL2_x86_64"
  description = "The AMI type to use for the node group"
}
variable "eks_module_version" {
  type        = string
  default     = "19.5.1"
  description = "The EKS module version to use" 
}
variable "cluster_version" {
  type        = string
  default     = "1.24"
  description = "The EKS version to use"  
}
  
variable "aws_region" {
  type        = string
  description = "The AWS region to deploy the VPC into"
  default     = "us-east-1"
  
}