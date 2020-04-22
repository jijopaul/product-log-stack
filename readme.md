# product-log-stack

Below is a copy of paimages-egress-stack, to be updated

## Notes from meeting with PA
* Create bucket:
```aws s3api create-bucket --bucket alamy-tfstate-dev --region eu-west-1 --create-bucket-configuration LocationConstraint=eu-west-1```
* Create DynamoDB table:
```aws dynamodb create-table --table-name terraform_remote_lock --region eu-west-1 --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5```
* Install Terraform 11: ```brew install terraform@0.11```
* Initialise terraform project:
```terraform init```
* Create terraform workspace:
```terraform workspace new qa```
* Create plan:
```terraform plan --var-file="workspaces/qa.tfvars"```
* Apply to create stack:
```terraform apply --var-file="workspaces/qa.tfvars"```
* Get secret key output:
```terraform output sqs_alamy_secret_key```
* Subscribe to SNS queue manually (need to use a profile with keys from PA)
```aws sns subscribe --topic-arn arn:aws:sns:eu-west-1:683339657374:images-sns-relay-alamy_staging --protocol sqs --notification-endpoint $(terraform output sqs_alamy_ingress_arn)```
* Destroy stack:
```terraform destroy --var-file="workspaces/qa.tfvars"```

A terraform stack that stands up an SQS queue subscribed to an SNS topic that is used to deliver a stream of notifications relating to ingest of images into the PA Images stack.  This can then be used as an ingress point for ingest to the Alamy platform.

## Pre-Requisites

* [Terraform](https://www.terraform.io/)
* AWS Credentials

## Deploying Infrastructure Upgrades

If the infrastructure changes then follow the below instructions to deploy upgrades:

1. Move to the terraform folder: ```cd terraform```
2. Initialise the modules: ```terraform init```
3. Select the appropriate workspace for deployment (e.g. qa): ```terraform workspace select qa```
4. Check for changes/errors: ```terraform plan --var-file="workspaces/qa.tfvars```
5. Execute the deployment: ```terraform apply --var-file="workspaces/qa.tfvars```
6. Acquire the output variables for updating the task defintions (when changed): ```terraform output```
