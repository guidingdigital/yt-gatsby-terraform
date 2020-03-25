resource "aws_s3_bucket_policy" "demo_s3_bucket_policy" {
    depends_on = [aws_s3_bucket_public_access_block.my_bucket_public_access_block]
    bucket = aws_s3_bucket.demo-s3-bucket.id
    policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "DEMOBUCKETPOLICY",
    "Statement": [
        {
            "Sid": "PublicRead",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "${aws_s3_bucket.demo-s3-bucket.arn}/*",
            "Condition": {
                "StringLike": {"aws:Referer": "${local.referer_key}" }
            }
        }
    ]
}
    POLICY
}