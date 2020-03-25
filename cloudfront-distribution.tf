locals {
  s3_origin_id = "myS3Origin"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    custom_origin_config {
        http_port = "80"
        https_port = "443"
        origin_protocol_policy = "http-only"
        origin_ssl_protocols = ["TLSv1.2"]
    }
    domain_name = aws_s3_bucket.demo-s3-bucket.website_endpoint
    origin_id   = local.s3_origin_id
    custom_header {
        name = "Referer"
        value = local.referer_key
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment = "demo cloudfront"

  aliases = [local.primary_domain_name, local.alternate_domain_name]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    compress = true
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = local.cloudfront_ttl
    default_ttl            = local.cloudfront_ttl
    max_ttl                = local.cloudfront_ttl

    lambda_function_association {
      event_type = "viewer-request"
      lambda_arn = local.redirect_lambda_arn
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn  = aws_acm_certificate_validation.cert.certificate_arn
    minimum_protocol_version  = "TLSv1.2_2018"
    ssl_support_method = "sni-only"
  }
}
