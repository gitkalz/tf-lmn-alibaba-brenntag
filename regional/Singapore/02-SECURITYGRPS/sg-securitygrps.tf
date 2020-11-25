data "terraform_remote_state" "vpc_id" {
  backend = "azurerm"
  config = {
    resource_group_name  = var.vpc_tfstate_ds.rg_name
    storage_account_name = var.vpc_tfstate_ds.strg_name
    container_name       = var.vpc_tfstate_ds.cntr_name
    key                  = var.vpc_tfstate_ds.key_path
  }
}

locals {
  sg_ids = flatten([
    for key in keys(var.secgrps) : [
      for items in alicloud_security_group.secgrp : {
        name   = lookup(items, "name", null)
        sg_id  = lookup(items, "id", null)
        config = var.secgrps[key]
      }
      if items.name == key
    ]
  ])
}

resource "alicloud_security_group" "secgrp" {
  for_each  = var.secgrps
  name   = each.key
  vpc_id = try(lookup(data.terraform_remote_state.vpc_id.outputs.all.vpc, "id", null), var.vpc_id)
  # lifecycle {
  #   ignore_changes = [
  #     # Ignore changes to tags, e.g. because a management agent
  #     # updates these based on some ruleset managed elsewhere.
  #     tags,
  #   ]
  # }
}

output "grps" {
  value = alicloud_security_group.secgrp
}

output "secgrp" {
  value = local.sg_ids
}

# resource "alicloud_security_group_rule" "rules" {
#   for_each          = { for sg in local.sg_ids : sg.name => sg }
#   type              = lookup(each.value.config, "type", null)
#   ip_protocol       = lookup(each.value.config, "ip_protocol", "tcp")
#   nic_type          = lookup(each.value.config, "nic_type", null)
#   policy            = lookup(each.value.config, "policy", null)
#   port_range        = lookup(each.value.config, "port_range", null)
#   priority          = lookup(each.value.config, "priority", null)
#   cidr_ip           = lookup(each.value.config, "cidr_ip", null)
#   security_group_id = each.value.sg_id
# }


resource "alicloud_security_group_rule" "rules" {
  count             = length(local.sg_ids)
  type              = lookup(local.sg_ids[count.index].config, "type", null)
  ip_protocol       = lookup(local.sg_ids[count.index].config, "ip_protocol", "tcp")
  nic_type          = lookup(local.sg_ids[count.index].config, "nic_type", null)
  policy            = lookup(local.sg_ids[count.index].config, "policy", null)
  port_range        = lookup(local.sg_ids[count.index].config, "port_range", null)
  priority          = lookup(local.sg_ids[count.index].config, "priority", null)
  cidr_ip           = lookup(local.sg_ids[count.index].config, "cidr_ip", null)
  security_group_id = local.sg_ids[count.index].sg_id
}