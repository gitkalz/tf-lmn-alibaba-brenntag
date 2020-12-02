# data "terraform_remote_state" "ds_secgrps" {
#   backend = "azurerm"
#   config = {
#     resource_group_name  = var.vpc_tfstate_ds.rg_name
#     storage_account_name = var.vpc_tfstate_ds.strg_name
#     container_name       = var.vpc_tfstate_ds.cntr_name
#     key                  = var.vpc_tfstate_ds.tfstate_path
#   }
# }

data "alicloud_kms_secrets" "ds_vsw_id_key" {
  name_regex = (var.ecs_config.vswitch_key_regex != "" && var.ecs_config.vswitch_key_regex != null) ? var.ecs_config.vswitch_key_regex : null
}

data "alicloud_kms_secret_versions" "ds_vsw_id_secret" {
  secret_name    = data.alicloud_kms_secrets.ds_vsw_id_key.secrets.0.id
  enable_details = true
}


locals {

  # sg_ids = [for i in var.ecs_config.sec_grps: 
  #           data.terraform_remote_state.ds_secgrps.outputs.sg_grps[i] 
  #            ]

  ecs_input_map = {
    num_instances   = var.ecs_config.num_instances
    name_pattern    = var.ecs_config.name_pattern
    image_id        = var.ecs_config.image_id
    instance_type   = var.ecs_config.instance_type
    security_groups = var.ecs_config.sec_grps
    dry_run         = var.ecs_config.dry_run
    data_disks      = var.ecs_config.data_disks
    tags            = var.ecs_config.tags
    vswitch_id      = (var.vsw_id != "" && var.vsw_id != null) ? var.vsw_id : try(data.alicloud_kms_secret_versions.ds_vsw_id_secret.versions.0.secret_data, null)
    password        = var.ecs_config.password
  }

  tags = {
    region    = data.alicloud_regions.current_region_ds.regions.0.id
    tf-dir    = basename(dirname(abspath(path.module)))
    tf-module = basename(abspath(path.module))
  }

}

resource "alicloud_instance" "deploys" {
  count           = local.ecs_input_map.num_instances
  image_id        = local.ecs_input_map.image_id
  instance_type   = local.ecs_input_map.instance_type
  vswitch_id      = local.ecs_input_map.vswitch_id
  instance_name   = local.ecs_input_map.num_instances > 1 ? format("%s%03d", local.ecs_input_map.name_pattern, count.index + 1) : local.ecs_input_map.name_pattern
  host_name       = local.ecs_input_map.num_instances > 1 ? format("%s%03d", local.ecs_input_map.name_pattern, count.index + 1) : local.ecs_input_map.name_pattern
  dry_run         = local.ecs_input_map.dry_run
  password        = local.ecs_input_map.password
  security_groups = local.ecs_input_map.security_groups
  tags            = merge(try(local.ecs_input_map.tags, {}), local.tags, { Name = local.ecs_input_map.num_instances > 1 ? format("%s-%03d", local.ecs_input_map.name_pattern, count.index + 1) : local.ecs_input_map.name_pattern })
  dynamic "data_disks" {
    for_each = local.ecs_input_map.data_disks
    content {
      category             = lookup(data_disks.value, "category", null)
      delete_with_instance = lookup(data_disks.value, "delete_with_instance", null)
      size                 = lookup(data_disks.value, "size", null)
      name                 = format("%s-%03d-%s", local.ecs_input_map.name_pattern, count.index + 1, data_disks.key)
    }
  }
}


output "ecs" {
  value = alicloud_instance.deploys
}

output "vsw_id_secret_data" {
  value = data.alicloud_kms_secret_versions.ds_vsw_id_secret.versions.0.secret_data
}
