variable "billing_code" {
  default = "Alamy"
}

variable "service" {
  default = "PAUpload"
}

variable "service_short_name" {
  default = "paupload"
}

variable "product" {
  default = "PA Images Egress"
}

variable "region" {
  default = "eu-west-1"
}

variable "profile" {
  default = ""
}

variable "notification_sns_arn" {
  default = ""
}

#
# EC2 PowerCycle (out of business hours scale down)
#
variable "ec2_powercycle" {
  default = ""
}
