terraform {
  backend "s3" {
    bucket       = "dns-eks-tf-state"
    key          = "dns/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }
}