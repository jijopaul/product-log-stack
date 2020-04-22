data "aws_caller_identity" "current" {}

data "aws_region" "current" {
}

data "aws_iam_policy_document" "sqs_owner_allow" {
  statement {
    effect = "Allow"

    actions = ["SQS:SendMessage"]

    resources = ["${aws_sqs_queue.ingest.arn}"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    condition {
      test     = "StringLike"
      variable = "aws:SourceArn"
      values   = ["arn:aws:sns:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}"]
    }
  }

  statement {
    effect = "Allow"

    actions = ["SQS:SendMessage"]

    resources = ["${aws_sqs_queue.ingest.arn}"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = ["${var.subscription_topic}"]
    }
  }
}

data "aws_iam_policy_document" "allow-alamy-ingest" {
  statement {
    effect = "Allow"

    actions = [
      "SQS:SendMessage",
      "SQS:ListQueues",
      "SQS:ReceiveMessage",
      "SQS:GetQueueAttributes",
      "SQS:DeleteMessage",
    ]

    resources = ["${aws_sqs_queue.ingest.arn}"]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = ["arn:aws:sns:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}"]
    }
  }
}

data "aws_iam_policy_document" "sqs_owner_allow_dlq" {
  statement {
    effect = "Allow"

    actions = ["SQS:SendMessage"]

    resources = ["${aws_sqs_queue.ingest_dead_letter.arn}"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}

