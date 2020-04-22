output "sqs_alamy_access_key" {
  value = "${module.queue.alamy_access_key}"
}

output "sqs_alamy_secret_key" {
  sensitive = true
  value = "${module.queue.alamy_secret_key}"
}

output "sqs_alamy_ingress_url" {
  value = "${module.queue.alamy_url}"
}

output "sqs_alamy_ingress_arn" {
  value = "${module.queue.alamy_arn}"
}
