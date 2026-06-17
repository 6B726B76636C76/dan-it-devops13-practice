# GENERAL INFO
output "region" {
    value = var.aws_region
}
output "jenkins-ec2-os" {
    description = "EC2 Jenkins instances OS"
    value = module.ec2-jenkins.ec2_instance_os
}
output "jenkins-ec2-type" {
    description = "EC2 Jenkins instances OS type"
    value = module.ec2-jenkins.ec2_instance_type
}


# JENKINS SERVER INSTANCE INFO
output "jenkins-server-instance-name" {
    description = "Instance name"
    value = module.ec2-jenkins.ec2_jenkins_server_name
}
output "jenkins-server-public-ip" {
    description = "Jenkins server public IP"
    value = module.ec2-jenkins.jenkins_server_public_ip
}

output "jenkins-server-private-ip" {
    description = "Jenkins server public IP"
    value = module.ec2-jenkins.jenkins_server_private_ip
}

output "jenkins-server-public-dns" {
    description = "Jenkins server public DNS"
    value = module.ec2-jenkins.jenkins_server_public_dns
}
output "jenkins-server-subnet-id" {
    description = "Jenkins server subnet ID"
    value = aws_subnet.public.id
}
output "jenkins-server-subnet-cidr" {
    description = "Jenkins server subnet CIDR"
    value = var.public_subnet_cidr
}
output "jenkins-server-open-ports" {
    description = "Jenkins server opened ports"
    value = module.ec2-jenkins.ec2_jenkinks_server_opened_ports
}
output "jenkins-server-http-port" {
    description = "Jenkins server opened public http port"
    value = 80
}
output "jenkins-server-ssh-key" {
    description = "SSH key name for Jenkins server"
    value = var.key_name
}


# JENKINS WORKER INSTANCE INFO
output "jenkins-worker-instance-name" {
    description = "Instance name"
    value = module.ec2-jenkins.ec2_jenkins_worker_name
}

output "jenkins-worker-private-ip" {
    description = "Jenkins worker private IP"
    value = module.ec2-jenkins.jenkins_worker_private_ip
}
output "jenkins-worker-subnet-id" {
    description = "Jenkins worker subnet ID"
    value = aws_subnet.private.id
}
output "jenkins-worker-subnet-cidr" {
    description = "Jenkins wirker subnet CIDR"
    value = var.private_subnet_cidr
}
output "jenkins-worker-ssh-key" {
    description = "SSH key name for Jenkins worker"
    value = var.key_name
}
output "jenkins-worker-ssh-allowed-network" {
    description = "Network for SSH acces to Jenkins worker"
    value = var.public_subnet_cidr
}
