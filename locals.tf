locals {
  referer_key = "jJB23u002zBZ14gh50gD"
  primary_domain_name = "www.example.com"
  alternate_domain_name = "example.com"
  redirect_lambda_arn = "arn:aws:lambda:us-east-1:123456789:function:NonWWWRedirect:1"
  region = "us-east-1"
  cloudfront_ttl = 31536000
  s3_bucket_name = "website-s3-bucket-name"
}