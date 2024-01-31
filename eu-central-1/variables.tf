variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "aws_key_path" {}

variable "aws_key_name" {
  default = "project-r"
}

variable "AWS_REGION" {
  description = "EC2 Region for the VPC"
  default     = "eu-central-1"
}

variable "amis" {
  description = "AMIs by region"

  default = {
    eu-central-1 = "ami-0f5eaf4f17ca1d6d5"
  }
}

variable "vpc_cidr" {
  description = "CIDR for the whole VPC"
  default     = "10.4.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the Public Subnet"
  default     = "10.4.0.0/24"
}

variable "public_subnet_cidr_2" {
  description = "CIDR for the Public Subnet"
  default     = "10.4.1.0/24"
}

