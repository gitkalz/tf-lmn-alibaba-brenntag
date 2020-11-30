
data "alicloud_regions" "current_region_ds" {
  current = true
}

output "current_region_id" {
  value = data.alicloud_regions.current_region_ds.regions.0.id
}

# output "sg_grps" {
#   value = alicloud_security_group.secgrp
# }

output "sg_grps" {
  value = tomap({
    for i, l in alicloud_security_group.secgrp :
    l.name => l.id
  })
}

output "vpc_id" {
  value = (var.vpc_id != "" && var.vpc_id != null) ? var.vpc_id  : data.terraform_remote_state.vpc_config.outputs.vpc_id
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

