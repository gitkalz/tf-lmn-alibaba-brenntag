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
  sg_num = keys(var.secgrps)
  # sg_ids = flatten([
  #   for i, j in local.sg_num : [
  #     for a, b in alicloud_security_group.secgrp : {
  #       "${j}" = lookup(b, "id", null)
  #     } if b.name == j
  #   ]
  # ])
  sg_ids = flatten([
    for i, j in keys(var.secgrps) : [
      for a, b in alicloud_security_group.secgrp : {
            name = j
            id = lookup(b, "id", null)
            config = var.secgrps[j]
        }
      if b.name == j
    ]
  ])

}

resource "alicloud_security_group" "secgrp" {
  count  = length(local.sg_num)
  name   = local.sg_num[count.index]
  vpc_id = try(lookup(data.terraform_remote_state.vpc_id.outputs.all.vpc, "id", null), var.vpc_id)
}

output "grps" {
  value = alicloud_security_group.secgrp
}

# output "secgrp" {
#   value = flatten([
#     for i, j in local.sg_num : [
#       for a, b in alicloud_security_group.secgrp : {
#         "${j}" = {
#             name = lookup(b, "id", null) 
#         }
#         }
#       if b.name == j
#     ]
#   ])
# }

output "secgrp" {
  value = flatten([
    for i, j in keys(var.secgrps) : [
      for a, b in alicloud_security_group.secgrp : {
            name = lookup(b, "name", null)
            id = lookup(b, "id", null)
            config = var.secgrps[j]
        }
      if b.name == j
    ]
  ])
}


resource "alicloud_security_group_rule" "rules" {
    count = length(local.sg_ids)
    type        = lookup(local.sg_ids[count.index].config, "type", null)
    ip_protocol = lookup(local.sg_ids[count.index].config, "ip_protocol", "tcp")
    nic_type    = lookup(local.sg_ids[count.index].config, "nic_type", null)
    policy      = lookup(local.sg_ids[count.index].config, "policy", null)
    port_range  = lookup(local.sg_ids[count.index].config, "port_range", null)
    priority    = lookup(local.sg_ids[count.index].config, "priority", null)
    cidr_ip     = lookup(local.sg_ids[count.index].config, "cidr_ip", null)
    security_group_id = local.sg_ids[count.index].id
}