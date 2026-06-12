variable "vpc_id" {
    description = "vpc where resources will be created"
    type = string
}

variable "instance_name" {
    description = "Name tag for the EC2 instance"
    type        = string
    default     = "ec2-instance"
}

variable "cidr_ipv4" {
    description = "Allow public access to the ec2"
    type = string
    default = "0.0.0.0/0"
}

variable "instance_type" {
    description = "EC2 instance type"
    type        = string
    default     = "t3.micro"
}

variable "subnet_id" {
    description = "ID of the public subnet where the EC2 instance will be launched"
    type        = string
}

variable "my_ip" {
    type    = string
    default = "176.37.37.63/32"
}

variable "key_name" {
    type = string
    description = "ssh key name"
    default = "ec2-key-task"
}