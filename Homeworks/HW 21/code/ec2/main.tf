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

resource "aws_security_group" "ec2-sg" {
    name        = "ec2-sg"
    description = "Security group for EC2 instance"
    vpc_id      = var.vpc_id

    ingress {
        description = "HTTP"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = [var.cidr_ipv4]
    }

    ingress {
        description = "HTTPS"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = [var.cidr_ipv4]
    }

    ingress {
        description = "SSH from my IP only"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [var.my_ip]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = [var.cidr_ipv4]
    }

    tags = {
        Name = "ec2-sg"
    }
}

resource "aws_instance" "ec2-instance" {
    count = 2

    ami                    = data.aws_ami.debian.id
    instance_type          = var.instance_type
    vpc_security_group_ids = [aws_security_group.ec2-sg.id]
    associate_public_ip_address = true
    subnet_id              = var.subnet_id
    key_name               = var.key_name

    tags = {
        Name      = "${var.instance_name}-${count.index + 1}"
        ManagedBy = "Terraform"
    }
}
