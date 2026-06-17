variable "vpc_cidr" {
    description = "CIDR block for VPC"
    type        = string
    default     = "10.0.0.0/16"
}

variable "cidr_ipv4" {
    description = "CIDR for seurity group"
    type        = string
    default     = "0.0.0.0/0"
}

variable "aws_region" {
    type        = string
    description = "Default region"
    default     = "eu-central-1"
}

variable "public_subnet_cidr" {
    description = "CIDR block for public subnet"
    type        = string
    default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
    description = "CIDR block for subnet"
    type        = string
    default     = "10.0.2.0/24"
}

variable "key_name" {
    type = string
    description = "ssh key name"
    default = "ec2-key-task"
}