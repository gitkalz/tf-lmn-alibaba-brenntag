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
  value = module.vpc.current_region_id
}

output "subnets_list" {
  value = [for keys,items in module.vpc.subnets: {
        "${items.name}" = {
          "id" = items.id
          "ip_cidr" = items.cidr_block
          "zone" = items.availability_zone
          "description" = items.description
          }
      }]
}