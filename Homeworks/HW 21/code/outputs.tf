output "region" {
    description = "Region"
    value = var.aws_region
}

output "ec2_instance_name" {
    description = "Instance name"
    value = module.ec2.ec2_instance_name
}

output "ec2_instance_type" {
    description = "Instance type"
    value = module.ec2.ec2_instance_type
}

output "ec2_instance_os" {
    description = "EC2 OS version"
    value = module.ec2.ec2_instance_os
}

output "ec2_instance_security_group" {
    description = "EC2 security group"
    value = module.ec2.ec2_instance_security_group
}

output "ec2_instance_public_ip" {
    description = "Public IP of the EC2 instance"
    value       = module.ec2.ec2_instance_public_ip
}
