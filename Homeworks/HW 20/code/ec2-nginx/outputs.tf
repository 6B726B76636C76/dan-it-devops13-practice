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
    value = aws_security_group.nginx_scg.name
}


output "ec2_instance_open_ports" {
    description = "List of opened EC2 instance ports"
    value = toset(var.ports_list)
}

output "ec2_instance_public_ip" {
    description = "Public IP of the EC2 nginx instance"
    value       = "http://${aws_instance.ec2-nginx-server.public_ip}"
}