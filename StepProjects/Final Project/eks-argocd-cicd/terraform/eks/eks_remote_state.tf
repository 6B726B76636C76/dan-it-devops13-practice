data "terraform_remote_state" "dns" {
  backend = "s3"
  config = {
    bucket = "dns-eks-tf-state"
    key    = "dns/terraform.tfstate"
    region = "eu-central-1"
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "network-eks-tf-state"
    key    = "network/terraform.tfstate"
    region = "eu-central-1"
  }
}