data "terraform_remote_state" "vpc_id" {
  backend = "azurerm"
  config = {
    resource_group_name  = var.vpc_tfstate_ds.rg_name
    storage_account_name = var.vpc_tfstate_ds.strg_name
    container_name       = var.vpc_tfstate_ds.cntr_name
    key                  = var.vpc_tfstate_ds.key_path
  }
}

resource "alicloud_nat_gateway" "sgnatgw" {
  vpc_id        = try(lookup(data.terraform_remote_state.vpc_id.outputs.all.vpc, "id", null), var.vpc_id)
  name          = var.natgw_config.natgw_name
  specification = var.natgw_config.natgw_spec
  description   = var.natgw_config.natgw_desc
  nat_type = "Enhanced"
  vswitch_id = try(lookup(data.terraform_remote_state.vpc_id.outputs.all.subnets.snet2, "id", null), var.vsw_id)
}

resource "alicloud_eip" "eip" {
  name = "EIP-NATGW-01"
  internet_charge_type = "PayByTraffic"
}

resource "alicloud_eip_association" "eip_asso" {
  allocation_id = alicloud_eip.eip.id
  instance_id   = alicloud_nat_gateway.sgnatgw.id
}
