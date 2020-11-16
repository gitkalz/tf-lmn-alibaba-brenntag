data "terraform_remote_state" "vpc_id" {
  backend = "azurerm"
  config = {
    resource_group_name  = "lmn-sg-ops-rg"
    storage_account_name = "lmnapacops"
    container_name       = "tfstates"
    key                  = "alicloud/btg/01-global/ap-southeast-1/VPC/terraform.tfstate"
  }
}

resource "alicloud_vpn_gateway" "sg_vgw" {
  name                 = var.vgw_name
  vpc_id               = try(lookup(data.terraform_remote_state.vpc_id.outputs.all.vpc, "id", null), var.vpc_id)
  bandwidth            = "10"
  enable_ipsec         = true
  enable_ssl           = false
  instance_charge_type = "PostPaid"
  description          = "Brenntag Singapore AliCloud VPN Gateway 01"
}

resource "alicloud_vpn_customer_gateway" "sg_cgw" {
  name        = var.cgw_name
  ip_address  = "42.104.22.228"
  description = "Brenntag Singapore IBM IPSec Tunnel IP"
}

resource "alicloud_vpn_connection" "vpn_conn" {
  name                = var.conn_name
  vpn_gateway_id      = alicloud_vpn_gateway.sg_vgw.id
  customer_gateway_id = alicloud_vpn_customer_gateway.sg_cgw.id
  local_subnet        = ["192.168.12.0/22"]
  remote_subnet       = ["172.16.32.0/22"] # On-Prem Ranges
  effect_immediately  = true
  ike_config {
    ike_version   = "ikev2"
    psk           = var.sg_psk
  }
}