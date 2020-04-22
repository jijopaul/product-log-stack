resource "aws_sqs_queue" "ingest" {
  name                        = "${var.service}_${terraform.env}"
  delay_seconds               = 0
  max_message_size            = 131072
  message_retention_seconds   = 86400
  receive_wait_time_seconds   = 0
  redrive_policy              = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.ingest_dead_letter.arn}\",\"maxReceiveCount\":5}"
  visibility_timeout_seconds  = "180"

  tags {
    Name        = "${var.service}-${var.name}_${terraform.env}"
    Service     = "${var.service}"
    Environment = "${terraform.env}"
    BillingCode = "${var.billing_code}"
  }
}

resource "aws_sqs_queue" "ingest_dead_letter" {
  name                      = "${var.service}-dead-letter_${terraform.env}"
  delay_seconds             = 0
  max_message_size          = 131072
  message_retention_seconds = 86400
  receive_wait_time_seconds = 0

  tags {
    Name        = "${var.service}-${var.name}_${terraform.env}"
    Service     = "${var.service}"
    Environment = "${terraform.env}"
    BillingCode = "${var.billing_code}"
    Environment = "${terraform.env}"
  }
}

resource "aws_sqs_queue_policy" "allow_owner" {
  queue_url = "${aws_sqs_queue.ingest.id}"
  policy    = "${data.aws_iam_policy_document.sqs_owner_allow.json}"
}

resource "aws_sqs_queue_policy" "allow_owner_dlq" {
  queue_url = "${aws_sqs_queue.ingest_dead_letter.id}"
  policy    = "${data.aws_iam_policy_document.sqs_owner_allow_dlq.json}"
}

resource "aws_sns_topic_subscription" "sqs" {
  protocol  = "sqs"
  topic_arn = "${var.subscription_topic}"
  endpoint  = "${aws_sqs_queue.ingest.arn}"
}
