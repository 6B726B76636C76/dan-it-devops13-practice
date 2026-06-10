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
variable "my_ip" {
  type    = string
  default = "176.37.37.63/32"
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

