variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}


variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "my_ip" {
  description = "Your IP address for SSH access (format: x.x.x.x/32)"
  type        = string
}

variable "key_name" {
  description = "Name of existing AWS Key Pair for SSH access"
  type        = string
}
