output "all" {
  value = {
    vpc     = alicloud_vpc.vpc
    subnets = alicloud_subnet.subnets
  }
}

data "alicloud_regions" "current_region_ds" {
  current = true
}

output "current_region_id" {
  value = data.alicloud_regions.current_region_ds.regions.0.id
}