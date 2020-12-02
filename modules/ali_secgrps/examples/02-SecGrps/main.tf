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
    key                  = "alicloud/BRNTAG/regional/sg-mdls/02-SecGrps/terraform.tfstate"
  }
}

provider "alicloud" {
  # Configuration options
  region = var.region
}

data "alicloud_vpcs" "vpcs_ds" {
  status     = "Available"
  name_regex = var.vpc_name_regex
}

module "secgrps" {
  source  = "../../../modules/ali_secgrps/"
  region  = var.region
  secgrps_config = var.secgrps_config
  vpc_id = local.vpc_id
  tags    = local.tags
}

locals {
  tags = merge(try(var.tags, {}), { tf_dir = "${basename(dirname(abspath(path.root)))}/${basename(abspath(path.root))}" })
  vpc_id = (var.vpc_id != "" && var.vpc_id != null) ? var.vpc_id  : try(data.alicloud_vpcs.vpcs_ds.ids.0,null)
}
