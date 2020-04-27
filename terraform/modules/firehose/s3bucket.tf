resource "aws_s3_bucket" "kinesis_firehose_stream_bucket" {
  bucket = "tf-test-firehose-bucket"
  acl    = "private"
  lifecycle_rule {
    id      = "logs"
    enabled = true
    expiration {
      days = 90
    }
  }
}
