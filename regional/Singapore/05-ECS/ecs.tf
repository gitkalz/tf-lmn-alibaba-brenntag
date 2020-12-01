data "alicloud_kms_secrets" "ds_vpc_id_key" {
  name_regex = var.vpc_name_regex
}

data "alicloud_kms_secret_versions" "ds_vpc_id_secret" {
  secret_name    = data.alicloud_kms_secrets.ds_vpc_id_key.secrets.0.id
  enable_details = true
}

data "alicloud_kms_secrets" "ds_vsw_id_key" {
  name_regex = var.ecs_config.vswitch_key_regex
}

data "alicloud_kms_secret_versions" "ds_vsw_id_secret" {
  secret_name    = data.alicloud_kms_secrets.ds_vsw_id_key.secrets.0.id
  enable_details = true
}

# locals {
#   tags = {
#     region    = data.alicloud_regions.current_region_ds.regions.0.id
#     tf-dir    = basename(dirname(abspath(path.module)))
#     tf-module = basename(abspath(path.module))
#   }
#   vpc_id = (var.vpc_id != "" && var.vpc_id != null) ? var.vpc_id : try(data.alicloud_kms_secret_versions.ds_vpc_id_secret.versions.0.secret_data, null)
#   esc_config1 = {

#   }
#   keys(var.ecs_config)[0]
# }

locals {
  vpc_id = (var.vpc_id != "" && var.vpc_id != null) ? var.vpc_id : try(data.alicloud_kms_secret_versions.ds_vpc_id_secret.versions.0.secret_data, null)
  ecs_input_map = {
    num_instances   = var.ecs_config.num_instances
    name_pattern    = var.ecs_config.name_pattern
    image_id        = var.ecs_config.image_id
    instance_type   = var.ecs_config.instance_type
    security_groups = var.ecs_config.sec_grps
    dry_run         = var.ecs_config.dry_run
    data_disks      = var.ecs_config.data_disks
    vswitch_id      = data.alicloud_kms_secret_versions.ds_vsw_id_secret.versions.0.secret_data
    password        = var.ecs_config.password
    # name = var.name != "" ? var.name : var.instance_name != "" ? var.instance_name : "TF-Module-ECS-Instance"
    # hostname = var.host_name == "" ? "" : var.number_of_instances > 1 || var.use_num_suffix ? format("%s%03d", var.host_name, count.index + 1) : var.host_name
  }

}


resource "alicloud_instance" "this" {
  count           = local.ecs_input_map.num_instances
  image_id        = local.ecs_input_map.image_id
  instance_type   = local.ecs_input_map.instance_type
  vswitch_id      = local.ecs_input_map.vswitch_id
  instance_name   = local.ecs_input_map.num_instances > 1 ? format("%s%03d", local.ecs_input_map.name_pattern, count.index + 1) : local.ecs_input_map.name_pattern
  host_name       = local.ecs_input_map.num_instances > 1 ? format("%s%03d", local.ecs_input_map.name_pattern, count.index + 1) : local.ecs_input_map.name_pattern
  dry_run         = local.ecs_input_map.dry_run
  password        = local.ecs_input_map.password
  security_groups = local.ecs_input_map.security_groups
  dynamic "data_disks" {
    for_each = local.ecs_input_map.data_disks
    content {
      category             = lookup(data_disks.value, "category", null)
      delete_with_instance = lookup(data_disks.value, "delete_with_instance", null)
      size                 = lookup(data_disks.value, "size", null)
    }
  }
}


output "sample" {
  value = local.ecs_input_map
}

output "ecs" {
  value = alicloud_instance.this
}
