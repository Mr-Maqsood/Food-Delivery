variable "aws_region" {
  default = "us-east-1"
}

variable "cluster_name" {
  default = "food-delivery-eks"
}

variable "cluster_version" {
  default = "1.31"   
}

variable "vpc_cidr" {
  default = "10.10.0.0/16"
}

variable "azs" {
  default = ["us-east-1a", "us-east-1b"]
}

variable "public_subnets" {
  default = ["10.10.0.0/24", "10.10.1.0/24"]
}

variable "private_subnets" {
  default = ["10.10.10.0/24", "10.10.11.0/24"]
}