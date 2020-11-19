output "natgw_id" {
  value = alicloud_nat_gateway.sgnatgw.id
}

output "natgw_eip" {
  value = alicloud_eip.eip.ip_address
}
data "alicloud_regions" "current_region_ds" {
  current = true
}

output "current_region_id" {
  value = data.alicloud_regions.current_region_ds.regions.0.id
}