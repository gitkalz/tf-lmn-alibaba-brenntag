output "vpc_id" {
  value = module.vpc.vpc_id
}

output "your_account_ID" {
  value = module.vpc.current_account_id
}

output "vpc_name" {
  value = module.vpc.vpc_name
}

output "deployed_in" {
  value = module.vpc.current_region
}

# output "subnets_list" {
#   value = flatten([for keys,items in module.vpc.subnets: {
#         (items.name) = { # Noteworthy parenthesis around items.name
#           "id" = items.id
#           "ip_cidr" = items.cidr_block
#           "zone" = items.availability_zone
#           "description" = items.description
#           }
#       }])
# }


# Noteworthy that above output generates a list/tuple and the below output generates a map..note the flatten segment is same from above.
output "snet_map" {
  value = {for items in flatten([for keys,vals in module.vpc.subnets: {
        (vals.name) = { # Noteworthy parenthesis around items.name
          "id" = vals.id
          "ip_cidr" = vals.cidr_block
          "zone" = vals.availability_zone
          "description" = vals.description
          }
      }]): keys(items)[0] => values(items)[0]}
}