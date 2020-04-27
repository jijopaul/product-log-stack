resource "aws_kinesis_firehose_delivery_stream" "test_stream" {
  name        = "terraform-kinesis-firehose-test-stream"
  destination = "s3"

  s3_configuration {
    role_arn   = "${aws_iam_role.kinesis_firehose_stream_role.arn}"
    bucket_arn = "${aws_s3_bucket.kinesis_firehose_stream_bucket.arn}"
  }
}
