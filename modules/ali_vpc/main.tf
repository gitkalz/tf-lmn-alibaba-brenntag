provider "alicloud" {
  region = var.region
}

resource "alicloud_vpc" "vpc" {
  name        = lookup(var.vpc_config, "name", null)
  cidr_block  = lookup(var.vpc_config, "cidr", null)
  description = lookup(var.vpc_config, "desc", null)
  tags        = merge(try(var.tags, {}), local.tags)
}

data "alicloud_regions" "current_region_ds" {
  current = true
}

locals {
  vpc_subnets = toset(flatten([
    for snets in var.vpc_config.subnets : {
      "vpc_name" = alicloud_vpc.vpc.name
      "vpc_id"   = alicloud_vpc.vpc.id
      "subnet"   = snets
    }
    ])
  )
  tags = {
    region    = data.alicloud_regions.current_region_ds.regions.0.id
    tf_module = basename(abspath(path.module))
  }
}

data "alicloud_enhanced_nat_available_zones" "default" {
}

resource "alicloud_subnet" "subnets" {
  for_each          = tomap({ for subnets in local.vpc_subnets : subnets.subnet.name => subnets })
  vpc_id            = lookup(each.value, "vpc_id", null)
  availability_zone = each.value.subnet.tags.role == "DMZ" ? data.alicloud_enhanced_nat_available_zones.default.zones[0].zone_id : lookup(each.value.subnet, "az", null)
  description = lookup(each.value.subnet, "desc", null)
  name        = lookup(each.value.subnet, "name", null)
  cidr_block  = lookup(each.value.subnet, "cidr", null)
  tags        = merge(try(var.tags, {}), try(each.value.subnet.tags, {}), local.tags)
}
