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
    for grps, rules in var.secgrps : [
      for grpkeys, grpvals in alicloud_security_group.secgrp : [
        for items in toset(rules) : {
          "name"  = grpvals.name
          "id"    = grpvals.id
          "rules" = items
        }
      ] if grps == grpvals.name
    ]
  ])

  tags = {
    region    = data.alicloud_regions.current_region_ds.regions.0.id
    tf-dir    = basename(dirname(abspath(path.module)))
    tf-module = basename(abspath(path.module))
  }
}

resource "alicloud_security_group" "secgrp" {
  for_each = var.secgrps
  name     = each.key
  vpc_id   = try(lookup(data.terraform_remote_state.vpc_id.outputs.all.vpc, "id", null), var.vpc_id)
  tags     = local.tags
  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
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
  for_each          = { for items in local.sg_ids : "${items.name}.${items.rules.ip_protocol}.${replace(items.rules.port_range, "/", "|")}" => items }
  type              = lookup(each.value.rules, "type", null)
  ip_protocol       = lookup(each.value.rules, "ip_protocol", "tcp")
  nic_type          = lookup(each.value.rules, "nic_type", null)
  policy            = lookup(each.value.rules, "policy", null)
  port_range        = lookup(each.value.rules, "port_range", null)
  priority          = lookup(each.value.rules, "priority", null)
  cidr_ip           = lookup(each.value.rules, "cidr_ip", null)
  security_group_id = each.value.id
}


# resource "alicloud_security_group_rule" "rules" {
#   count             = length(local.sg_ids.config)
#   type              = lookup(local.sg_ids[count.index].config, "type", null)
#   ip_protocol       = lookup(local.sg_ids[count.index].config, "ip_protocol", "tcp")
#   nic_type          = lookup(local.sg_ids[count.index].config, "nic_type", null)
#   policy            = lookup(local.sg_ids[count.index].config, "policy", null)
#   port_range        = lookup(local.sg_ids[count.index].config, "port_range", null)
#   priority          = lookup(local.sg_ids[count.index].config, "priority", null)
#   cidr_ip           = lookup(local.sg_ids[count.index].config, "cidr_ip", null)
#   security_group_id = local.sg_ids[count.index].sg_id
# }