# Terraform state will be stored in S3
terraform {
  backend "s3" {
    bucket = "cicd-jen-ter-buck"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

# Use AWS Terraform provider
provider "aws" {
  region = "us-east-1"
}

# Create EC2 instance
resource "aws_instance" "default" {
  ami                    = var.ami
  count                  = var.instance_count
  vpc_security_group_ids = "terraform-default-sg"
  source_dest_check      = false
  instance_type          = var.instance_type

  tags = {
    Name = "terraform-default"
  }
}
