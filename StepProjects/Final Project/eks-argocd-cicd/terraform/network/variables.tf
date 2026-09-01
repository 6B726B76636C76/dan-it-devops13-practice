variable "name" {}
variable "region" {
  default = "eu-central-1"
}
variable "iam_profile" {}
variable "tags" {}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}