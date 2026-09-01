
provider "aws" {
  region  = var.region
  profile = var.iam_profile
}

terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 3.0.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
  }
}


provider "kubernetes" {
  host                   = aws_eks_cluster.danit.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.danit.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.danit.token
}

provider "helm" {
  kubernetes = {
    host                   = aws_eks_cluster.danit.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.danit.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.danit.token
  }
}

provider "kubectl" {
  host                   = aws_eks_cluster.danit.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.danit.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.danit.token
  load_config_file       = false
}
data "aws_availability_zones" "available" {}

