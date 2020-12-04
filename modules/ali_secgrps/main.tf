provider "alicloud" {
  region = var.region
}

data "alicloud_regions" "current_region_ds" {
  current = true
}

resource "alicloud_security_group" "secgrp" {
  for_each = var.secgrps_config
  name     = "${each.key}_secgrp"
  vpc_id = local.vpc_id
  tags     = merge(try(var.tags, {}), local.tags)
  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

locals {
  sg_ids = flatten([
    for grpkeys, grpvals in alicloud_security_group.secgrp : [
      for grps, rules in var.secgrps_config : [
        for items in toset(rules) : {
          "name"  = grpvals.name
          "id"    = grpvals.id
          "rules" = items
        }
      ] if "${grps}_secgrp" == grpvals.name
    ]
  ])

  tags = {
    region    = data.alicloud_regions.current_region_ds.regions.0.id
    tf_module = basename(abspath(path.module))
  }

  vpc_id = (length(var.vpc_id) > 4 && substr(var.vpc_id, 0, 4) == "vpc-") ? var.vpc_id  : "VPC Not Defined | This deployment will fail check var.vpc_id"
}

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
