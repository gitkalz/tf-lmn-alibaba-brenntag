output "all" {
  value = {
    vpc     = alicloud_vpc.sgvpc
    subnets = alicloud_subnet.subnets
  }
}