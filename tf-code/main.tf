terraform {
  required_version = ">= 0.12"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  default_tags {
   tags = {
     Owner       = "Rahul Trivedi"
    }
  }
  region = var.region
  access_key = var.AccessKey
  secret_key = var.SecretKey
}

#Comment
