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

resource "aws_instance" "jenkins_server" {
    ami = data.aws_ami.debian.id
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.jenkins_server_sg.id]
    associate_public_ip_address = true
    subnet_id = var.public_subnet_id
    key_name = var.key

    tags = {
        Name      = var.instance_name_jenkins_server
        ManagedBy = "Terraform"
    }

}

resource "aws_instance" "jenkins_worker" {
    ami = data.aws_ami.debian.id
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.jenkins_worker_sg.id]
    subnet_id = var.private_subnet_id
    key_name = var.key
    

    instance_market_options {
        market_type = "spot"
        spot_options {
            spot_instance_type = "one-time"
        }
    }
    
    tags = {
        Name      = var.instance_name_jenkins_worker
        ManagedBy = "Terraform"
    }
}