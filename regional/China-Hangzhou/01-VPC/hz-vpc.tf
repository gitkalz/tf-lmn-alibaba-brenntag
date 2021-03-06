resource "alicloud_vpc" "vpc" {
  name        = var.vpc.name
  cidr_block  = var.vpc.cidr
  description = var.vpc.desc
  tags = merge(try(var.tags, {}), local.tags)
}

resource "alicloud_subnet" "subnets" {
  for_each          = var.subnets
  vpc_id            = alicloud_vpc.hzvpc.id
  availability_zone = each.value.az
  description       = each.value.desc
  name              = each.value.name
  cidr_block        = each.value.cidr
  tags    = merge(try(var.tags, {}), try(each.value.tags, {}), { Subnet = each.key }, local.tags)
}