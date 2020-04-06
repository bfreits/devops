#!/bin/basb
cd /devops/terraform
terraform init
terraform apply --auto-approve -var-file=/home/ubuntu/devops/var.tfvars
