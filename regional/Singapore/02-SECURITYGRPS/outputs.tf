
data "alicloud_regions" "current_region_ds" {
  current = true
}

output "current_region_id" {
  value = data.alicloud_regions.current_region_ds.regions.0.id
}

output "sg_grps_full" {
  value = alicloud_security_group.secgrp
}

output "sg_grps" {
  value = tomap({
    for i, l in alicloud_security_group.secgrp :
    l.name => l.id
  })
}

output "sg_ruls_full" {
  value = alicloud_security_group_rule.rules
}

output "sg_rules" {
  value = tomap({
    for i, l in alicloud_security_group.secgrp :
    l.name => {
      for k, v in alicloud_security_group_rule.rules :
      l.id => v.id...
      if l.id == v.security_group_id
    }
  })
}

output "ds_vpc_id" {
  value = local.vpc_id
}

# output "ds_secrets" {
#   value = data.alicloud_kms_secrets.kms_secrets_ds
# }

output "local_tuple" {
  value = local.sg_ids
}

output "local_map" {
  value = { for items in local.sg_ids : "${items.name}.${items.rules.ip_protocol}.${replace(items.rules.port_range, "/", "|")}" => items }
}