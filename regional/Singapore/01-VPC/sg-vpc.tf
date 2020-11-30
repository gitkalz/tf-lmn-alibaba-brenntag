resource "alicloud_vpc" "vpc" {
  name        = lookup(var.vpc, "name", null)
  cidr_block  = lookup(var.vpc, "cidr", null)
  description = lookup(var.vpc, "desc", null)
  tags        = merge(try(var.tags, {}), local.tags)
}

locals {
  vpc_subnets = toset(flatten([
    for snets in var.vpc.subnets : {
      "vpc_name" = alicloud_vpc.vpc.name
      "vpc_id"   = alicloud_vpc.vpc.id
      "subnet"   = snets
    }
  ])
  )
}

# vpc_config = flatten([
#     for grpkeys, grpvals in alicloud_vpc.vpc : [
#       for vpc, items in var.vpc : [
#         for snets in items.subnets : {
#           "vpc_name" = items.name
#           "vpc_id"   = grpvals.id
#           "subnet"   = snets
#         }
#       ] if grpvals.name == items.name
#     ]
#   ])



resource "alicloud_subnet" "subnets" {
  for_each          = tomap({ for subnets in local.vpc_subnets : subnets.subnet.name => subnets })
  vpc_id            = lookup(each.value, "vpc_id", null)
  availability_zone = lookup(each.value.subnet, "az", null)
  description       = lookup(each.value.subnet, "desc", null)
  name              = lookup(each.value.subnet, "name", null)
  cidr_block        = lookup(each.value.subnet, "cidr", null)
  tags              = merge(try(var.tags, {}), try(each.value.tags, {}), local.tags)
}

