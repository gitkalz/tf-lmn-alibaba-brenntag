output "all" {
  value = {
    vpc = alicloud_vpc.sgvpc
    net1 = alicloud_subnet.snet1
    net2 = alicloud_subnet.snet2
    net3 = alicloud_subnet.snet3
  }
}