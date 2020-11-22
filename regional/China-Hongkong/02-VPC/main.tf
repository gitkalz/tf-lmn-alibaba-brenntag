terraform {
  required_providers {
    alicloud = {
      source  = "aliyun/alicloud"
      version = "1.103.1"
    }
  }
  # Import the Azure ENV Variables or use Az Login
  backend "azurerm" {
    resource_group_name  = "lmn-sg-ops-rg"
    storage_account_name = "lmnapacops"
    container_name       = "tfstates"
    key                  = "alicloud/BRNTAG/regional/China-Shanghai/02-VPC/terraform.tfstate"
  }
}

provider "alicloud" {
  # Configuration options
  region = var.region
}

module "vpc" {
  source  = "../../../modules/ali_vpc/"
  region = var.region
  vpc     = var.vpc
  subnets = var.subnets
  tags    = var.tags
}