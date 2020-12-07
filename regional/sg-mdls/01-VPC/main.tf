terraform {
  required_providers {
    alicloud = {
      source  = "aliyun/alicloud"
      version = "~> 1.105.0"
    }
  }
  # Import the Azure ENV Variables or use Az Login
  backend "azurerm" {
    resource_group_name  = "lmn-sg-ops-rg"
    storage_account_name = "lmnapacops"
    container_name       = "tfstates"
    key                  = "alicloud/BRNTAG/regional/sg-mdls/01-VPC/terraform.tfstate"
  }
}

provider "alicloud" {
  # Configuration options
  region = var.region
}

module "vpc" {
  source     = "../../../modules/ali_vpc/"
  region     = var.region
  vpc_config = var.vpc_config
  tags       = local.tags
}

locals {
  tags = merge(try(var.tags, {}), { tf_dir = "${basename(dirname(abspath(path.root)))}/${basename(abspath(path.root))}" })
}

