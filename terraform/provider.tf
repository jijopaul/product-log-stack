provider "aws" {
  profile = "${var.profile}"
  region  = "eu-west-1"
  version = ">= 2.39.0"
}

terraform {
  backend "s3" {
    bucket         = "alamy-tfstate-dev"
    key            = "paimages-egress-stack/terraform.tfstate"
    region         = "eu-west-1"
    profile        = "NickHDev"
    dynamodb_table = "terraform_remote_lock"
  }

  required_version = ">= 0.11.7"
}
