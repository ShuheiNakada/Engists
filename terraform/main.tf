# -------------------------------------------
# Terraform configuration
# -------------------------------------------
terraform {
  required_version = ">=1.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}

# -------------------------------------------
# Provider
# -------------------------------------------
provider "aws" {
  profile = "terraform"
  region  = "ap-northeast-1"
}

provider "aws" {
  alias   = "virginia"
  profile = "terraform"
  region  = "us-east-1"
}

# -------------------------------------------
# Variables
# -------------------------------------------
variable "tool" {
  type = string
}

variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "domain" {
  type = string
}
