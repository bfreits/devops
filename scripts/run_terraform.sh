#!/bin/basb
cd /devops/terraform
terraform apply --auto-approve -var-file=/home/ubuntu/devops/var.tfvars
