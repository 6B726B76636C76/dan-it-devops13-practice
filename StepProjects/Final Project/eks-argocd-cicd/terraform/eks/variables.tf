variable "name" {
}
variable "tags" {
}
variable "github_pat" {
  sensitive = true
}
variable "region" {
  description = "aws region"
  default     = "eu-central-1"
}
variable "iam_profile" {
  description = "Profile of aws creds"
  default     = null
}
variable "zone_name" {
}
variable "image_updater_ssh_private_key" {
  sensitive = true
}
#export TF_VAR_image_updater_ssh_private_key="$(cat /home/$USER/image-updater-key)"
#echo $TF_VAR_image_updater_ssh_private_key