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
  aws_vpc_cidr_block = var.aws_vpc_cidr_block
  aws_vpc_public_subnets = var.aws_vpc_public_subnets
  eks-public-subnet = module.subnet.eks-public-subnet
}

module "subnet" {
  source = "./modules/subnet"
  aws_vpc_public_subnets = var.aws_vpc_public_subnets
  eks_vpc = module.vpc.eks_vpc
}


module "security_group" {
  source = "./modules/security-group"
  eks_vpc = module.vpc.eks_vpc
}

module "iam" {
  source = "./modules/iam"
}

module "s3" {
  source = "./modules/s3"
  bucket_name = "terraform-state-s3-20250304"
}

module "dynamodb" {
  source = "./modules/dynamodb"
  terraform-s3-bucket = module.s3.terraform-s3-bucket
}


module "eks" {
  source = "./modules/eks"
  eks-iam-cluster = module.iam.eks-iam-cluster
  eks-iam-nodes = module.iam.eks-iam-nodes
  eks-cluster-policy-attachment = module.iam.eks-cluster-policy-attachment
  eks-cluster-resource-attachment = module.iam.eks-cluster-resource-attachment
  eks-worker-node-policy-attachment = module.iam.eks-worker-node-policy-attachment
  eks-worker-cni-policy-attachment = module.iam.eks-worker-cni-policy-attachment
  eks-worker-ec2-policy-attachment = module.iam.eks-worker-ec2-policy-attachment
  eks-public-subnet = module.subnet.eks-public-subnet
  eks-sg-control-plane = module.security_group.eks-sg-control-plane
  eks-sg-nodes = module.security_group.eks-sg-nodes
}