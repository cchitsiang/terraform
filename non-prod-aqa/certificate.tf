// ACM Certificate
resource "aws_acm_certificate" "cert" {
  domain_name       = var.env_domain
  validation_method = "DNS"

  tags = merge(map(
        "Name", var.env_domain,
        "EMAIL_DISTRIBUTION", var.email
  ), var.common_tags)
}

// DNS zone ID from Prod
data "aws_route53_zone" "zone" {
  provider     = aws.prod
  name         = var.domain_zone
  private_zone = false
}

// Route53 validation record in Prod
resource "aws_route53_record" "cert_validation" {
  provider = aws.prod
  name     = aws_acm_certificate.cert.domain_validation_options.0.resource_record_name
  type     = aws_acm_certificate.cert.domain_validation_options.0.resource_record_type
  zone_id  = data.aws_route53_zone.zone.id
  records  = [aws_acm_certificate.cert.domain_validation_options[0].resource_record_value]
  ttl      = 60
}

// Validate certificate
resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}
