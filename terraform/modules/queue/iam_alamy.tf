resource "aws_iam_user" "alamy" {
  name = "${var.service}-${terraform.env}"
  path = "/users/alamy/"
}

resource "aws_iam_access_key" "alamy" {
  user = "${aws_iam_user.alamy.name}"
}

resource "aws_iam_user_policy" "alamy" {
  name   = "${var.service}-${terraform.env}"
  user   = "${aws_iam_user.alamy.name}"
  policy = "${data.aws_iam_policy_document.alamy.json}"
}

data "aws_iam_policy_document" "alamy" {
  statement {
    sid    = "AllowUserToGetSQSMessage"
    effect = "Allow"

    actions = [
      "sqs:ReceiveMessage",
      "sqs:GetQueueUrl",
      "sqs:GetQueueAttributes",
      "sqs:ListQueues",
      "sqs:DeleteMessage",
    ]

    resources = ["${aws_sqs_queue.ingest.arn}","${aws_sqs_queue.ingest_dead_letter.arn}"]
  }
}
