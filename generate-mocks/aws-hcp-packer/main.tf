variable "bucket_name" {
  description = "The name of the HCP Packer bucket to use"
  type        = string
}

variable "region" {
  description = "The AWS region to deploy the instance in"
  type        = string
}

variable "HCP_CLIENT_ID" {
  sensitive = true
}

variable "HCP_CLIENT_SECRET" {
  sensitive = true
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

provider "hcp" {
  client_id     = var.HCP_CLIENT_ID
  client_secret = var.HCP_CLIENT_SECRET
}

data "hcp_packer_artifact" "bucket" {
  channel_name = "latest"
  platform     = "aws"
  bucket_name  = var.bucket_name
  region       = var.region
}

resource "aws_instance" "hcp_packer" {
  ami           = data.hcp_packer_artifact.bucket.external_identifier
  instance_type = "t2.micro"
}
