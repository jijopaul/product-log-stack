module "firehose" {
  source              = "modules/firehose"
  name                = "firehose"
  service             = "product-log"
  billing_code        = "${var.billing_code}"
  environment         = "${terraform.env}"
}
