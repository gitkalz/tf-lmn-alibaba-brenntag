data "terraform_remote_state" "vpc_id" {
  backend = "azurerm"
  config = {
    resource_group_name  = "lmn-sg-ops-rg"
    storage_account_name = "lmnapacops"
    container_name       = "tfstates"
    key                  = "alicloud/btg/01-global/ap-southeast-1/VPC/terraform.tfstate"
  }
}


resource "alicloud_nat_gateway" "sgnatgw" {
  vpc_id        = try(lookup(data.terraform_remote_state.vpc_id.outputs.all.vpc, "id", null), var.vpc_id)
  name          = var.natgw_name
  specification = var.natgw_spec
  description   = "A Nat Gateway created by terraform-alicloud-modules/nat-gateway"
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
