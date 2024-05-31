terraform {
  required_version = "> 1.1.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    
  }
}

data "aws_caller_identity" "current" {}

data "aws_subnet_ids" "public" {
  depends_on = [module.vpc]
  vpc_id = module.vpc.vpc_id
  tags = {
    Tier = "Public"
  }
}

data "aws_subnet" "subnet" {
  depends_on = [module.vpc]
  count = length(data.aws_subnet_ids.public.ids)
  id    = tolist(data.aws_subnet_ids.public.ids)[count.index]
}

locals {
  env  = var.env
  project = "Test"
  vpc_cidr = var.vpc_cidr
  account_id = data.aws_caller_identity.current.account_id
  region = var.region
  common_tags = tomap({
    "Env"= var.env,
    "Project"= "Test",
    "ManagedBy"="Terraform"
  })
}