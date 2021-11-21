terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      "source" = "hashicorp/aws"
    }
  }
  backend "s3" {
    profile        = "sellix-terraform"
    bucket         = "sellix-deployments"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "sellix-deployments"
    key            = "aws-chatbot.tfstate"
  }
}

provider "aws" {
  profile    = "sellix-terraform"
  region     = "eu-west-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

provider "aws" {
  alias      = "us-east-1"
  profile    = "sellix-terraform"
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}