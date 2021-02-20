terraform {
    required_providers {
        aws = "~> 2.33"
    }

    backend "s3" {
        bucket         = "nvsimpr-terraform-states"
        region         = "us-east-1"
        profile        = "asurion-simplr-nonprod.appadmins"
        key            = "nvsimplr-aqa/terraform.tfstate"
        dynamodb_table = "nvsimplr-aqa-tfstate-lock"
    }
}

// AWS NON-PROD Account
provider "aws" {
    region   = "us-east-1"
    profile  = "asurion-simplr-nonprod.appadmins"
}

// AWS PROD Account.
// Used only for Route53 certificate validation and ALB alias records
provider "aws" {
    alias    = "prod"
    region   = "us-east-1"
    profile  = "asurion-simplr-prod.appadmins"
}
