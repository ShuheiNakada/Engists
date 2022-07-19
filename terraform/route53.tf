# -------------------------------------------
# Route53
# -------------------------------------------
### ドメインの取得(レジストリ：Route53) ###
data "aws_route53_zone" "hostzone" {
  name = var.domain
}

### Aレコード：ALB ###
resource "aws_route53_record" "a_record_alb" {
  zone_id = data.aws_route53_zone.hostzone.zone_id
  name    = data.aws_route53_zone.hostzone.name
  type    = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

output "domain_name" {
  value = aws_route53_record.a_record_alb
}

### Aレコード：CloudFront ###
resource "aws_route53_record" "a_record_cloudfront" {
  zone_id = data.aws_route53_zone.hostzone.zone_id
  name    = "www.${var.domain}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cf.domain_name
    zone_id                = aws_cloudfront_distribution.cf.hosted_zone_id
    evaluate_target_health = true
  }
}

### 証明書のDNS検証用レコード ###
resource "aws_route53_record" "route53_acm_dns_resolve" {
  for_each = {
    for dvo in aws_acm_certificate.tokyo_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  allow_overwrite = true
  zone_id         = data.aws_route53_zone.hostzone.zone_id
  name            = each.value.name
  type            = each.value.type
  records         = [each.value.record]
  ttl             = 60
}