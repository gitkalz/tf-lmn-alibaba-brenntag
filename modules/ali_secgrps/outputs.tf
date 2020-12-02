output "current_region" {
  value = data.alicloud_regions.current_region_ds.regions.0.id
}

output "sg_grps" {
  value = tomap({
    for i, l in alicloud_security_group.secgrp :
    l.name => l.id
  })
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


output "vpc_id" {
  value = element(values(alicloud_security_group.secgrp),0).vpc_id
}