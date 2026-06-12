output "ec2_instance_name" {
    description = "Instance name"
    value = var.instance_name
}

output "ec2_instance_type" {
    description = "Instance type"
    value = var.instance_type
}

output "ec2_instance_os" {
    description = "EC2 OS version"
    value = data.aws_ami.debian.name
}

output "ec2_instance_security_group" {
    description = "EC2 security group"
    value = aws_security_group.ec2-sg.name
}

output "ec2_instance_public_ip" {
    description = "Public IPs of the EC2 instances"
    value       = aws_instance.ec2-instance[*].public_ip
}
