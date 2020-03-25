resource "aws_s3_bucket_public_access_block" "my_bucket_public_access_block" {
  bucket = aws_s3_bucket.demo-s3-bucket.id

  block_public_acls   = false
  block_public_policy = false
}

resource "aws_s3_bucket" "demo-s3-bucket" {
    bucket = local.s3_bucket_name

    website {
        index_document = "index.html"
        error_document = "404.html"
    }
}