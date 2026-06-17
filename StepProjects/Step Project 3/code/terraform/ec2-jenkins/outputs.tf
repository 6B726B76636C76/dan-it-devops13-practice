output "ec2_jenkins_server_name" {
    description = "Jenkins server EC2 instance name"
    value = var.instance_name_jenkins_server
}

output "ec2_jenkins_worker_name" {
    description = "Jenkins worker EC2 instance name"
    value = var.instance_name_jenkins_worker
}

output "ec2_jenkinks_server_opened_ports" {
    description = "List of opened EC2 instance ports"
    value = toset(var.jenkins_server_ports_list)
}

output "ec2_instance_type" {
    description = "Instance type"
    value = var.instance_type
}

output "ec2_instance_os" {
    description = "EC2 OS version"
    value = data.aws_ami.debian.name
}
output "ec2_jenkins_server_security_group" {
    description = "Jenkins server security group"
    value = aws_security_group.jenkins_server_sg
}

output "ec2_jenkins_worker_security_group" {
    description = "Jenkins worker security group"
    value = aws_security_group.jenkins_worker_sg
}

output "jenkins_server_public_ip" {
    description = "Public IP of the EC2 Jenkins server"
    value       = aws_instance.jenkins_server.public_ip
}

output "jenkins_server_private_ip" {
    value = aws_instance.jenkins_server.private_ip
}

output "jenkins_worker_private_ip" {
    description = "Private IP of the EC2 Jenkins worker"
    value = aws_instance.jenkins_worker.private_ip
}

output "jenkins_server_public_dns" {
    description = "Public hostname of the EC2 Jenkins server"
    value       = "${aws_instance.jenkins_server.public_dns}"
}