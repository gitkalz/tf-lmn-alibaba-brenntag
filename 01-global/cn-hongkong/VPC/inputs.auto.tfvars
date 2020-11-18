region = "cn-hongkong"

vpc = {
  name = "BRNTG-CN-HK-SAP-VPC"
  desc = "Brenntag Hongkong VPC"
  cidr = "172.31.28.0/22"
}


subnets = {
  snet1 = {
    name = "BRNTG-SNET-ZH-VSW"
    az   = "cn-hongkong-b"
    cidr = "172.31.28.0/24"
    desc = "Subnet in Zone B Hongkong"
    tags = {
      Role = "Public"
    }
  }
  snet2 = {
    name = "BRNTG-SNET-ZI-VSW"
    az   = "cn-hongkong-c"
    cidr = "172.31.29.0/24"
    desc = "Subnet in Zone C Hongkong"
    tags = {
      Role = "Dev"
    }
  }
  snet3 = {
    name = "BRNTG-SNET-ZJ-VSW"
    az   = "cn-hongkong-d"
    cidr = "172.31.30.0/24"
    desc = "Subnet in Zone D Hongkong"
    tags = {
      Role = "Prod"
    }
  }
}

tags = {
  Owner = "Brenntag"
  MSP   = "Lumen"
}