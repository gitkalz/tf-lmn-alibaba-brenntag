
resource "alicloud_vpc" "sgvpc" {
  name        = var.vpc.name
  cidr_block  = var.vpc.cidr
  description = var.vpc.desc
  tags = merge(try(var.tags, {}), local.tags)
}

# resource "alicloud_subnet" "snet1" {
#   vpc_id            = alicloud_vpc.sgvpc.id
#   availability_zone = "ap-southeast-1a"
#   description       = "First SNET"
#   name              = "Subnet1"
#   cidr_block        = "192.168.12.0/24"
# }

# resource "alicloud_subnet" "snet2" {
#   vpc_id            = alicloud_vpc.sgvpc.id
#   availability_zone = "ap-southeast-1b"
#   description       = "Second SNET"
#   name              = "Subnet2"
#   cidr_block        = "192.168.13.0/24"
# }

# resource "alicloud_subnet" "snet3" {
#   vpc_id            = alicloud_vpc.sgvpc.id
#   availability_zone = "ap-southeast-1c"
#   description       = "Third SNET"
#   name              = "Subnet3"
#   cidr_block        = "192.168.14.0/24"
# }

resource "alicloud_subnet" "subnets" {
  for_each          = var.subnets
  vpc_id            = alicloud_vpc.sgvpc.id
  availability_zone = each.value.az
  description       = each.value.desc
  name              = each.value.name
  cidr_block        = each.value.cidr
  tags    = merge(try(var.tags, {}), try(each.value.tags, {}), { Subnet = each.key }, local.tags)
}