output "alamy_access_key" {
  value = "${aws_iam_access_key.alamy.id}"
}

output "alamy_secret_key" {
  sensitive = true
  value     = "${aws_iam_access_key.alamy.secret}"
}

output "alamy_url" {
  value = "${aws_sqs_queue.ingest.id}"
}

output "alamy_arn" {
  value = "${aws_sqs_queue.ingest.arn}"
}
