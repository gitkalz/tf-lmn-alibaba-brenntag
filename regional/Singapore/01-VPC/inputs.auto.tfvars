region = "ap-southeast-1"
 
vpc = {
    name = "BRNTG-SG-SAP-VPC"
    desc = "Brenntag Singapore VPC"
    cidr = "192.168.12.0/22" 
}

subnets = {
  snet1 = {
    name = "BRNTG-SNET-Z1A-VSW"
    az   = "ap-southeast-1a"
    cidr = "192.168.12.0/24"
    desc = "Subnet in Zone 1A Singapore"
    tags = {
        Role = "Public"
    }
  }
  snet2 = {
    name = "BRNTG-SNET-Z1B-VSW"
    az   = "ap-southeast-1b"
    cidr = "192.168.13.0/24"
    desc = "Subnet in Zone 1B Singapore"
    tags = {
        Role = "Dev"
    }
  }
  snet3 = {
    name = "BRNTG-SNET-Z1C-VSW"
    az   = "ap-southeast-1c"
    cidr = "192.168.14.0/24"
    desc = "Subnet in Zone 1C Singapore"
    tags = {
        Role = "Prod"
    }    
  }
}

tags = {
    Owner = "Brenntag"
    MSP = "Lumen"
}