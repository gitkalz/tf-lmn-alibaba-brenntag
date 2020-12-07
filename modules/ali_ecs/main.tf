provider "alicloud" {
  region = var.region
}


resource "alicloud_instance" "deploys" {
  count           = var.num_instances #assume 0 by default
  image_id        = var.ecs_input_map.image_id # Required
  instance_type   = var.ecs_input_map.instance_type # Required
  vswitch_id      = var.vswitch_id # Required
  instance_name   = var.num_instances > 1 ? format("%s%03d", var.ecs_input_map.name_pattern, count.index + 1) : var.ecs_input_map.name_pattern
  host_name       = var.num_instances > 1 ? format("%s%03d", var.ecs_input_map.name_pattern, count.index + 1) : var.ecs_input_map.name_pattern
  dry_run         = lookup(var.ecs_input_map,"dry_run", false) # assume false by default
  password        = var.instance_password # assume null by default
  security_groups = compact(var.ecs_input_map.sec_grp_ids) # Required
  user_data = (var.ecs_input_map.user_data != "" && var.ecs_input_map.user_data != null) ? var.ecs_input_map.user_data : null
  internet_max_bandwidth_out = lookup(var.ecs_input_map, "internet_max_bandwidth_out", "0" ) ## if anything greater than 0, a public IP will be assigned. 
  tags            = merge(try(var.ecs_input_map.tags, {}), var.tags, local.tags, { name = var.num_instances > 1 ? format("%s-%03d", var.ecs_input_map.name_pattern, count.index + 1) : var.ecs_input_map.name_pattern })
  dynamic "data_disks" {
    for_each = var.ecs_input_map.data_disks
    content {
      category             = lookup(data_disks.value, "category", null)
      delete_with_instance = lookup(data_disks.value, "delete_with_instance", null)
      size                 = lookup(data_disks.value, "size", null)
      name                 = format("%s-%03d-%s", var.ecs_input_map.name_pattern, count.index + 1, data_disks.key)
    }
  }
}

data "alicloud_regions" "current_region_ds" {
  current = true
}

locals {
  tags = {
    region    = data.alicloud_regions.current_region_ds.regions.0.id
    tf_module = basename(abspath(path.module))
  }
}