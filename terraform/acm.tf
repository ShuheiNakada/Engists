# -------------------------------------------
# AWS Certificate Manager
# -------------------------------------------
### 1、ALB用のHTTPS証明書 ###
resource "aws_acm_certificate" "tokyo_cert" {
  domain_name       = var.domain
  validation_method = "DNS"

  tags = {
    Name = "${var.tool}-${var.project}-${var.environment}-alb-sslcert"
  }

  lifecycle {
    create_before_destroy = true
  }
}

### 証明書のDNS検証 ###
resource "aws_acm_certificate_validation" "cert_valid" {
  certificate_arn         = aws_acm_certificate.tokyo_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.route53_acm_dns_resolve : record.fqdn]
}

### 2、CloudFront用のHTTPS証明書 ###
resource "aws_acm_certificate" "virginia_cert" {
  provider          = aws.virginia
  domain_name       = "*.${var.domain}"
  validation_method = "DNS"

  tags = {
    Name = "${var.tool}-${var.project}-${var.environment}-cloudfront-sslcert"
  }

  lifecycle {
    create_before_destroy = true
  }
}