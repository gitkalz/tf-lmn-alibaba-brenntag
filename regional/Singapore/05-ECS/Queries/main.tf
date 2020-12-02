
provider "alicloud" {
  # Configuration options
  region = "ap-southeast-1"
}


data "alicloud_zones" "zones_ds" {
  available_instance_type = "ecs.t6-c1m2.large"
  available_disk_category = "cloud_efficiency"
}

data "alicloud_instance_types" "types_ds" {
  cpu_core_count       = 1
  memory_size          = 2
  availability_zone    = "ap-southeast-1a"
  instance_type_family = "ecs.t5"
}

data "alicloud_images" "images_ds" {
  owners     = "system"
  name_regex = "^ubuntu_20"
}

data "alicloud_vpcs" "vpcs_ds" {
  status     = "Available"
  name_regex = "^.*SG.*VPC$"
}

output "vpc_id" {
  value = data.alicloud_vpcs.vpcs_ds.ids.0
}


# output "instance_avail" {
#     value = data.alicloud_instance_types.types_ds
# }

# output "ubuntu_img" {
#     value = data.alicloud_images.images_ds
# }

