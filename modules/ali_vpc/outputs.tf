output "subnets" {
  value = alicloud_subnet.subnets
}

output "vpc_name" {
  value = alicloud_vpc.vpc.name
}

output "vpc_id" {
  value = alicloud_vpc.vpc.id
}

data "alicloud_account" "current" {
}

output "current_account_id" {
  value = data.alicloud_account.current.id
}

output "current_region" {
  value = data.alicloud_regions.current_region_ds.regions.0.id
}
