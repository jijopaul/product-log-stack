resource "aws_iam_role" "kinesis_firehose_stream_role" {
  name               = "kinesis_firehose_stream_role"
  assume_role_policy = "${data.aws_iam_policy_document.kinesis_firehose_stream_assume_role.json}"
}

resource "aws_iam_role_policy" "kinesis_firehose_access_bucket_policy" {
  name   = "kinesis_firehose_access_bucket_policy"
  role   = "${aws_iam_role.kinesis_firehose_stream_role.name}"
  policy = "${data.aws_iam_policy_document.kinesis_firehose_access_bucket_assume_policy.json}"
}
