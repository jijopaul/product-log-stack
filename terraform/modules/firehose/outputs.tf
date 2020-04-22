output "firehose_id" {
  value = "${aws_kinesis_firehose_delivery_stream.test_stream.id}"
}
