data "terraform_remote_state" "vpc_id" {
  backend = "azurerm"
  config = {
    resource_group_name  = var.vpc_tfstate_ds.rg_name
    storage_account_name = var.vpc_tfstate_ds.strg_name
    container_name       = var.vpc_tfstate_ds.cntr_name
    key                  = var.vpc_tfstate_ds.key_path
  }
}

resource "alicloud_security_group" "group" {
  name   = "new-group"
  vpc_id = alicloud_vpc.vpc.id
}