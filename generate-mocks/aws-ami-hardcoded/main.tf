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

resource "aws_launch_configuration" "example" {
  name_prefix   = "example-lc-"
  image_id      = var.ami_id
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example" {
  name                 = "example-asg"
  max_size             = 1
  min_size             = 1
  desired_capacity     = 1
  launch_configuration = aws_launch_configuration.example.name
  # vpc_zone_identifier  = [] # Add your subnet IDs here, e.g., ["subnet-xxxxxx"]

  tag {
    key                 = "Name"
    value               = "example-asg-instance"
    propagate_at_launch = true
  }
}
