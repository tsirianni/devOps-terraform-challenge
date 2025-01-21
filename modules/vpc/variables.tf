variable "vpc_cidr_block" {
  type        = string
  description = "The CIDR block for the VPC"
}

variable "private_subnet_cidr_block" {
  type        = string
  description = "The CIDR block for the Private Subnet"
}

variable "public_subnet_cidr_block" {
  type        = string
  description = "The CIDR block for the Public Subnet"
}

variable "env" {
  description = "The environment name (dev, staging, prod)"
  type        = string
}