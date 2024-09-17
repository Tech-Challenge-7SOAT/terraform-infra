terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.62"
    }
  }
}

provider "aws" {
  region = var.AWS_REGION
  access_key  = var.AWS_ACCESS_KEY_ID
  secret_key  = var.AWS_SECRET_ACCESS_KEY
  token       = var.AWS_SESSION_TOKEN
}

provider "github" {
  version = "6.2.2"
  token = var.GIT_TOKEN
}