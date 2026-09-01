terraform {
  backend "s3" {
    bucket       = "network-eks-tf-state"
    key          = "network/terraform.tfstate"
    region       = "eu-central-1"
    encrypt      = true
    use_lockfile = true
  }
}