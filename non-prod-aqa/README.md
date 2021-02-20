Terraform IaC for non-prod QA Automation environment
Terraform states files stored in the nvsimpr-terraform-states S3 bucket.
Terraform lock state stored in the nvsimplr-aqa-tfstate-lock DynamoDB table.
Look at main.tf and variables.tf files for details.

Use terraform init to install all modules and check configuration
Use terraform plan to check terraform state and what will be updated
Use terraform apply to update or add any resources
