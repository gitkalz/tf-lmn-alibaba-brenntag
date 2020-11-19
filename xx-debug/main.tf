terraform {
  required_providers {
    alicloud = {
      source  = "aliyun/alicloud"
      version = "1.103.1"
    }
  }
}

provider "alicloud" {
  # Configuration options
  region = "cn-hongkong"
}


data "alicloud_enhanced_nat_available_zones" "enhanced" {
}

output "nat" {
  value = data.alicloud_enhanced_nat_available_zones.enhanced
}

data "alicloud_zones" "zones_ds" {
  available_resource_creation = "VSwitch"
  network_type = "Vpc"
}

output "az" {
  value = data.alicloud_zones.zones_ds.ids
}

data "alicloud_account" "current" {
}

output "current_account_id" {
  value = data.alicloud_account.current
}

data "alicloud_regions" "current_region_ds" {
  current = true
}

output "current_region_id" {
  value = data.alicloud_regions.current_region_ds.regions.0.id
}