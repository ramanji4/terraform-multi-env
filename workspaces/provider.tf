terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.96.0"
    }
  }
  backend "s3" {
    bucket = "devops-practice-with-aws"
    key    = "workspaces"
    region = "us-east-1"
    dynamodb_table = "DevOps-Practice"
  } 
} 

provider "aws" {
  # Configuration options
  region = "us-east-1"
}