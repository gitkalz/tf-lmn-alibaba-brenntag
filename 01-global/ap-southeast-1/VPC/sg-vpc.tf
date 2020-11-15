
resource "alicloud_vpc" "sgvpc" {
  name        = "BRNTG-SG-VPC"
  cidr_block  = "192.168.12.0/22"
  description = "This is Test VPC Deployed from Terraform"
  tags = {
    "Owner" = "Kalyan"
  }
}

resource "alicloud_subnet" "snet1" {
  vpc_id            = alicloud_vpc.sgvpc.id
  availability_zone = "ap-southeast-1a"
  description       = "First SNET"
  name              = "Subnet1"
  cidr_block        = "192.168.12.0/24"

}

resource "alicloud_subnet" "snet2" {
  vpc_id            = alicloud_vpc.sgvpc.id
  availability_zone = "ap-southeast-1b"
  description       = "Second SNET"
  name              = "Subnet2"
  cidr_block        = "192.168.13.0/24"

}
resource "alicloud_subnet" "snet3" {
  vpc_id            = alicloud_vpc.sgvpc.id
  availability_zone = "ap-southeast-1c"
  description       = "Third SNET"
  name              = "Subnet3"
  cidr_block        = "192.168.14.0/24"

}


output "all" {
  value = {
    vpc = alicloud_vpc.sgvpc
    net1 = alicloud_subnet.snet1
    net2 = alicloud_subnet.snet2
    net3 = alicloud_subnet.snet3
  }
}