output "all" {
  value = {
    vpc     = alicloud_vpc.hkvpc
    subnets = alicloud_subnet.subnets
  }
}

output "current_account_id" {
  value = data.alicloud_account.current
}

data "alicloud_regions" "current_region_ds" {
  current = true
}

output "current_region_id" {
  value = data.alicloud_regions.current_region_ds
}