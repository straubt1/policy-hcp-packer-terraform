variable "ami_id" {
  description = "The ID of the AMI to use for the instance"
  type        = string
}

variable "region" {
  description = "The AWS region to deploy the instance in"
  type        = string
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    hcp = {
      source = "hashicorp/hcp"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "hardcoded" {
  ami           = var.ami_id
  instance_type = "t2.micro"
}
