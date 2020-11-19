output "sgvgw" {
  value = {
    id     = alicloud_vpn_gateway.sg_vgw.id
    ip     = alicloud_vpn_gateway.sg_vgw.internet_ip
    status = alicloud_vpn_gateway.sg_vgw.status
  }
}

output "ipsec_conn" {
  value = {
    id         = alicloud_vpn_connection.vpn_conn.id
    ike_params = alicloud_vpn_connection.vpn_conn.ike_config
    status     = alicloud_vpn_connection.vpn_conn.status
  }
}

data "alicloud_regions" "current_region_ds" {
  current = true
}

output "current_region_id" {
  value = data.alicloud_regions.current_region_ds.regions.0.id
}

