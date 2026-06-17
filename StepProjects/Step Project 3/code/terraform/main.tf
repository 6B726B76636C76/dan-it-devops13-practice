terraform {
    required_version = "~> 1.5"

    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "6.2.0"
    }
    }

    backend "s3" {
        bucket = "vaclav-step-project-3"
        key    = "terraform.tfstate"
        region = "eu-central-1"
    }
}

resource "aws_vpc" "main" {
    cidr_block           = var.vpc_cidr
    enable_dns_support   = true
    enable_dns_hostnames = true

    tags = {
        Name = "main-vpc"
    }
}

resource "aws_subnet" "public" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = var.public_subnet_cidr
    availability_zone       = "${var.aws_region}a"
    map_public_ip_on_launch = true

    tags = {
        Name = "ec2-public-subnet"
    }
}

resource "aws_subnet" "private" {
    vpc_id            = aws_vpc.main.id
    cidr_block        = var.private_subnet_cidr
    availability_zone = "${var.aws_region}a"

    tags = {
        Name = "ec2-private-subnet"
    }
}

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "ec2-public-igw"
    }
}

resource "aws_eip" "nat" {
    domain = "vpc"

    tags = {
        Name = "ec2-nat-eip"
    }
}

resource "aws_nat_gateway" "main" {
    allocation_id = aws_eip.nat.id
    subnet_id     = aws_subnet.public.id 

    tags = {
        Name = "ec2-public-nat"
    }

    depends_on = [aws_internet_gateway.main]
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }

    tags = {
        Name = "public-rt"
    }
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block     = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.main.id
    }

    tags = {
        Name = "private-rt"
    }
}

resource "aws_route_table_association" "public" {
    subnet_id      = aws_subnet.public.id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
    subnet_id      = aws_subnet.private.id
    route_table_id = aws_route_table.private.id
}

module "ec2-jenkins" {
    source              = "./ec2-jenkins"
    vpc_id              = aws_vpc.main.id
    public_subnet_id    = aws_subnet.public.id
    private_subnet_id   = aws_subnet.private.id
    key                 = var.key_name
    
}

resource "local_file" "ansible_inventory" {
    content = templatefile("${path.module}/inventory.tpl", {
        server_ip         = module.ec2-jenkins.jenkins_server_public_ip
        server_private_ip = module.ec2-jenkins.jenkins_server_private_ip
        worker_ip         = module.ec2-jenkins.jenkins_worker_private_ip
    })
    filename = "../ansible/inventory.ini"
}
