resource "aws_security_group" "jenkins_server_sg" {
    name        = "jenkins-server-security-group"
    description = "Security group for Jenkins server"
    vpc_id      = var.vpc_id

    tags = {
        Name = "Jenkins server security group"
        ManagedBy = "Terraform"
    }
}

resource "aws_vpc_security_group_ingress_rule" "jenkins_server_allow_incoming_traffic" {
    security_group_id = aws_security_group.jenkins_server_sg.id
    
    #default [50000]
    for_each = toset([for port in var.jenkins_server_ports_list : tostring(port)])
    description = "Allow port ${each.value} from Jenkins worker"

    from_port = each.value
    to_port = each.value
    ip_protocol = "tcp"
    referenced_security_group_id = aws_security_group.jenkins_worker_sg.id

    tags = {
        Name        = "${var.instance_name_jenkins_server} ingress"
        Description = "Allowed incoming traffic to the Jenkins server"
        ManagedBy   = "Terraform"
    }
}

resource "aws_vpc_security_group_ingress_rule" "jenkins_server_allow_incoming_http_traffic" {
    security_group_id = aws_security_group.jenkins_server_sg.id
    cidr_ipv4         = var.cidr_ipv4
    from_port         = 80
    to_port           = 80
    ip_protocol = "tcp"

    tags = {
        Name        = "${var.instance_name_jenkins_server} ingress"
        ManagedBy   = "Terraform"
    }
}

resource "aws_vpc_security_group_ingress_rule" "jenkins_server_allow_incoming_ssh_access" {
    security_group_id = aws_security_group.jenkins_server_sg.id
    cidr_ipv4         = var.my_ip
    from_port         = 22
    to_port           = 22
    ip_protocol = "tcp"

    tags = {
        Name        = "${var.instance_name_jenkins_server} ingress"
        ManagedBy   = "Terraform"
    }
}

resource "aws_vpc_security_group_egress_rule" "jenkins_server_allow_outcoming_traffic" {
    security_group_id = aws_security_group.jenkins_server_sg.id
    cidr_ipv4         = var.cidr_ipv4
    ip_protocol       = "-1"

    tags = {
        Name        = "${var.instance_name_jenkins_server} egress"
        ManagedBy   = "Terraform"
    }
}

resource "aws_security_group" "jenkins_worker_sg" {
    name        = "jenkins-worker-security-group"
    description = "Security group for Jenkins worker"
    vpc_id      = var.vpc_id

    tags = {
        Name = "Jenkins worker security group"
        ManagedBy = "Terraform"
    }
}

resource "aws_vpc_security_group_ingress_rule" "jenkins_worker_allow_incoming_ssh_access" {
    security_group_id = aws_security_group.jenkins_worker_sg.id
    referenced_security_group_id = aws_security_group.jenkins_server_sg.id
    from_port         = 22
    to_port           = 22
    ip_protocol = "tcp"

    tags = {
        Type = "${var.instance_name_jenkins_worker} ingress"
        ManagedBy = "Terraform"
    }
}

resource "aws_vpc_security_group_egress_rule" "jenkins_worker_allow_outcoming_traffic" {
    security_group_id = aws_security_group.jenkins_worker_sg.id
    cidr_ipv4         = var.cidr_ipv4
    ip_protocol       = "-1"

    tags = {
        Name      = "${var.instance_name_jenkins_worker} egress"
        ManagedBy = "Terraform"
    }
}