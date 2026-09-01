variable "name" {
}
variable "tags" {
}
variable "student_name" { 
}
variable "region" {
  description = "aws region"
  default     = "eu-central-1"
}
variable "zone_name" {
}
variable "iam_profile" {
  description = "Profile of aws creds"
  default     = null
}
