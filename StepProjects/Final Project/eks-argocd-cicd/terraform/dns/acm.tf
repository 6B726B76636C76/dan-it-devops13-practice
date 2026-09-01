locals {
  domain_name = "${var.student_name}.${var.name}.${var.zone_name}"
}

module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "3.5.0"

  domain_name = local.domain_name
  zone_id     = aws_route53_zone.zone.zone_id

  subject_alternative_names = [
    "*.${local.domain_name}"
  ]

  wait_for_validation = true

  tags = var.tags
}