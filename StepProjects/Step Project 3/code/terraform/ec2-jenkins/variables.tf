variable "my_ip" {
    type    = string
    default = "176.37.37.63/32"
}

variable "vpc_id" {
    description = "VPC ID"
    type        = string
}

variable "cidr_ipv4" {
    description = "Allow public access to the ec2"
    type = string
    default = "0.0.0.0/0"
}

variable "jenkins_server_ports_list" {
    description = "list of open ports"
    type = list(number)
    default = [50000]
}

variable "instance_name_jenkins_server" {
    description = "Jenkins server instance name"
    type        = string
    default     = "EC2 Jenkins server"
}

variable "instance_name_jenkins_worker" {
    description = "Jenkins worker instance name"
    type        = string
    default     = "EC2 Jenkins worker"
}

variable "instance_type" {
    description = "EC2 instance type"
    type        = string
    default     = "t3.micro"
}

variable "key" {
    description = "SSH key name"
    type        = string
}

variable "public_subnet_id" {}
variable "private_subnet_id" {}