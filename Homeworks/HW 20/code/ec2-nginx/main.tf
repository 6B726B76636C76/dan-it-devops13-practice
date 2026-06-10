data "aws_ami" "debian" {
    most_recent = true
    owners      = ["136693071363"]

    filter {
        name   = "name"
        values = ["debian-13-amd64-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    filter {
        name   = "state"
        values = ["available"]
    }
}

resource "aws_security_group" "nginx_scg" {
    name        = "${var.instance_name}-sg"
    description = "security group for ec2/nginx"
    vpc_id      = var.vpc_id

    tags = {
        Name = "ec2-nginx-sg"
    }
}

resource "aws_vpc_security_group_ingress_rule" "ec2-nginx-incoming-traffic-sg-rule" {
    security_group_id = aws_security_group.nginx_scg.id

    for_each = toset([for port in var.ports_list : tostring(port)])
    description = "Allow port ${each.value} from anywhere"
    from_port = each.value
    to_port = each.value
    ip_protocol = "tcp"
    cidr_ipv4 =  var.cidr_ipv4

    tags = {
        Name      = "${var.instance_name}-ic-sg-rule"
        Description = "EC2 NGINX server's incoming network traffic rule"
        ManagedBy = "Terraform"
    }
}


resource "aws_vpc_security_group_egress_rule" "ec2-nginx-outcoming-traffic-sg-rule" {
    security_group_id = aws_security_group.nginx_scg.id
    cidr_ipv4 = var.cidr_ipv4
    ip_protocol = "-1"

    tags = {
        Name      = "${var.instance_name}-oc-sg-rule"
        Description = "EC2 NGINX server's outcoming network traffic rule"
        ManagedBy = "Terraform"
    }
}

resource "aws_instance" "ec2-nginx-server" {
    ami = data.aws_ami.debian.id
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.nginx_scg.id]
    associate_public_ip_address = true
    subnet_id = var.subnet_id

    user_data = <<-EOF
        #!/bin/bash
        set -e


        apt-get update -y

        apt-get install -y docker.io
        systemctl enable docker
        systemctl start docker

        docker run -d \
            --name nginx \
            --restart always \
            -p 80:80 \
            nginx:latest

        sleep 5
        docker ps | grep nginx
        EOF

    user_data_replace_on_change = true

    tags = {
        Name      = var.instance_name
        ManagedBy = "Terraform"
    }

}
