
output "sg_grps" {
  value = module.secgrps.sg_grps
  }

output "sg_rules" {
  value = module.secgrps.sg_rules
}


output "vpc_id" {
  value = module.secgrps.vpc_id
}