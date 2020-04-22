module "queue" {
  source              = "modules/queue"
  name                = "queue"
  service             = "paimages-egress"
  billing_code        = "${var.billing_code}"
  subscription_topic  = "${var.notification_sns_arn}"
  environment         = "${terraform.env}"
}
