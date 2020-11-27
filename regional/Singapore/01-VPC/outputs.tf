output "vpc_snets" {
  value = {
    vpc     = alicloud_vpc.vpc
    subnets = alicloud_subnet.subnets
  }
}

data "alicloud_account" "current" {
}

output "current_account_id" {
  value = data.alicloud_account.current
}

data "alicloud_regions" "current_region_ds" {
  current = true
}

output "current_region_id" {
  value = data.alicloud_regions.current_region_ds.regions.0.id
}

# output "subnet_list" {
#   value = flatten([
#     for grpkeys, grpvals in alicloud_vpc.vpc : [
#       for vpc, items in var.vpc : [
#         for snets in items.subnets : {
#           "vpc_name" = grpvals.name
#           "vpc_id"   = grpvals.id
#           "subnet"   = snets
#         }
#       ] if grpvals.name == items.name
#     ]
#   ])
# }