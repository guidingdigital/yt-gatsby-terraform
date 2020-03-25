resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.zone.id
  name    = local.primary_domain_name
  type    = "CNAME"
  ttl     = "300"
  records = [aws_cloudfront_distribution.s3_distribution.domain_name]
}

resource "aws_route53_record" "root" {
  zone_id = data.aws_route53_zone.zone.id
  name    = local.alternate_domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}