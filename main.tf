terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
  }
}
provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
}

module "security_group" {
  source = "./modules/security-group"
  eks_vpc_id = module.vpc.eks_vpc_id
}


module "s3" {
  source = "./modules/s3"
  bucket_name = "terraform-state-s3"
}

module "dynamodb" {
  source = "./modules/dynamodb"
  terraform-s3-bucket = module.s3.terraform-s3-bucket
}