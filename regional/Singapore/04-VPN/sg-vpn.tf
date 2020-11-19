data "terraform_remote_state" "vpc_id" {
  backend = "azurerm"
  config = {
    config = {
    resource_group_name  = var.vpc_tfstate_ds.rg_name
    storage_account_name = var.vpc_tfstate_ds.strg_name
    container_name       = var.vpc_tfstate_ds.cntr_name
    key    = var.vpc_tfstate_ds.key_path
  }
}

resource "alicloud_vpn_gateway" "sg_vgw" {
  name                 = var.vpn_config.vgw_name
  vpc_id               = try(lookup(data.terraform_remote_state.vpc_id.outputs.all.vpc, "id", null), var.vpc_id)
  bandwidth            = "10"
  enable_ipsec         = true
  enable_ssl           = false
  instance_charge_type = "PostPaid"
  description          = var.vpn_config.vgw_desc
}

resource "alicloud_vpn_customer_gateway" "sg_cgw" {
  name        = var.vpn_config.cgw_name
  ip_address  = var.vpn_config.cgw_ip
  description = var.vpn_config.vgw_name
}

resource "alicloud_vpn_connection" "vpn_conn" {
  name                = var.vpn_config.conn_name
  vpn_gateway_id      = alicloud_vpn_gateway.sg_vgw.id
  customer_gateway_id = alicloud_vpn_customer_gateway.sg_cgw.id
  local_subnet        = [var.vpn_config.cloud_subnets]
  remote_subnet       = [var.vpn_config.customer_subnets] # On-Prem Ranges
  effect_immediately  = true
  ike_config {
    ike_version = "ikev2"
    psk         = var.vpn_config.sg_psk
  }
}