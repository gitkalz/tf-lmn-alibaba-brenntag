output "all" {
  value = {
    vpc     = alicloud_vpc.vpc
    subnets = alicloud_subnet.subnets
  }
}

output "id" {
  value = alicloud_vpc.vpc.id
}

output "cidr_blks" {
  value = {for k, o in alicloud_subnet.subnets: k.id => o.cidr_block}
}

data "alicloud_regions" "current_region_ds" {
  current = true
}

output "current_region_id" {
  value = data.alicloud_regions.current_region_ds.regions.0.id
}