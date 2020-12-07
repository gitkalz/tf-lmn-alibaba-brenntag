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
    key                  = "alicloud/BRNTAG/regional/sg-mdls/05-ECS/terraform.tfstate"
  }
}

provider "alicloud" {
  # Configuration options
  region = var.region
}

data "alicloud_vswitches" "vsw_ds" {
  name_regex = var.vswitch_id_regex
}

module "ecs" {
  source        = "../../../modules/ali_ecs/"
  instance_password = random_password.instance_password.result
  region        = var.region
  vswitch_id    = local.vswitch_id
  num_instances = var.num_instances
  ecs_input_map = var.ecs_config
  tags          = local.tags
}

resource "random_password" "instance_password" {
 # Use Count if you want to generate multiple passwords
  length = 16
  special = true
  override_special = "_%@"
}


locals {
  tags = merge(try(var.tags, {}), { tf_dir = "${basename(dirname(abspath(path.root)))}/${basename(abspath(path.root))}" })
  vswitch_id = (var.vswitch_id != "" && var.vswitch_id != null) ? var.vswitch_id  : try(data.alicloud_vswitches.vsw_ds.ids.0,null)
}

## Save the Outputs in Key Management Service for retrieval in other modules

resource "alicloud_kms_secret" "instance_password" {
  secret_name                   = "${var.ecs_config.name_pattern}-instances_password"
  description                   = "Root Password for Instancecs created by Terraform"
  secret_data                   = random_password.instance_password.result
  version_id                    = "01"
  force_delete_without_recovery = true
  tags                          = merge(try(var.tags, {}), local.tags)
}