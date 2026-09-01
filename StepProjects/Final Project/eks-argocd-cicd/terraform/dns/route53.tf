resource "aws_route53_zone" "zone" {
  name    = var.zone_name
  comment = "Managed by Terraform for ${var.name} project"

  tags = var.tags
}