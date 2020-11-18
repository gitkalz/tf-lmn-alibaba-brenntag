region = "cn-hangzhou"

vpc = {
    name = "BRNTG-CN-HZ-SAP-VPC"
    desc = "Brenntag Hangzhou VPC"
    cidr = "172.31.28.0/22" 
    }

subnets = {
  snet1 = {
    name = "BRNTG-SNET-ZH-VSW"
    az   = "cn-hangzhou-g"
    cidr = "172.31.28.0/24"
    desc = "Subnet in Zone H Singapore"
    tags = {
        Role = "Public"
    }
  }
  snet2 = {
    name = "BRNTG-SNET-ZI-VSW"
    az   = "cn-hangzhou-h"
    cidr = "172.31.29.0/24"
    desc = "Subnet in Zone I Singapore"
    tags = {
        Role = "Dev"
    }
  }
  snet3 = {
    name = "BRNTG-SNET-ZJ-VSW"
    az   = "cn-hangzhou-i"
    cidr = "172.31.30.0/24"
    desc = "Subnet in Zone J Singapore"
    tags = {
        Role = "Prod"
    }    
  }
}

tags = {
    Owner = "Brenntag"
    MSP = "Lumen"
}