output "natgw_id" {
    value = alicloud_nat_gateway.sgnatgw.id
}

output "natgw_eip" {
    value = alicloud_eip.eip.ip_address
}