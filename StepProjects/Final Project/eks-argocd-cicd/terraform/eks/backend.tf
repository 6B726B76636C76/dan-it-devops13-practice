terraform {
  backend "s3" {
    bucket       = "danit-eks-tf-state"
    key          = "eks/terraform.tfstate"
    region       = "eu-central-1"
    encrypt      = true
    use_lockfile = true
  }
}