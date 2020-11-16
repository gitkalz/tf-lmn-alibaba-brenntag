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
  region = "ap-southeast-1"
}


data "alicloud_enhanced_nat_available_zones" "enhanced"{
}

output "nat" {
    value = data.alicloud_enhanced_nat_available_zones.enhanced
}

data "alicloud_zones" "zones_ds" {

}

output "az" {
    value = data.alicloud_zones.zones_ds.ids
}
