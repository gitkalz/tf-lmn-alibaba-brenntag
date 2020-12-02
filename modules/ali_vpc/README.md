**VPC Module is tested working as on Dec 2 2020**

Sample input.auto.tfvars as shown below

```hcl
region = "ap-southeast-1"

vpc_config = {
  name = "BRNTG-SG-SAP-VPC"
  desc = "Brenntag Singapore VPC"
  cidr = "192.168.12.0/22"
  subnets = {
    snet1 = {
      name = "BRNTG-SNET-Z1A-VSW"
      az   = "ap-southeast-1a"
      cidr = "192.168.12.0/24"
      desc = "Subnet in Zone 1A Singapore"
      tags = {
        role    = "Z1AVSW" # modify to any role you may chose
        purpose = "SAP"
      }
    }
    snet2 = {
      name = "BRNTG-SNET-Z1B-VSW"
      az   = "ap-southeast-1b"
      cidr = "192.168.13.0/24"
      desc = "Subnet in Zone 1B Singapore"
      tags = {
        role    = "Z1BVSW" # modify to any role you may chose
        purpose = "SAP"
      }
    }
    snet3 = {
      name = "BRNTG-SNET-Z1C-VSW"
      az   = "ap-southeast-1c"
      cidr = "192.168.14.0/24"
      desc = "Subnet in Zone 1C Singapore"
      tags = {
        role    = "Z1CVSW" # modify to any role you may chose
        purpose = "SAP"
      }
    }
    snet4 = {
      name = "BRNTG-SNET-DMZ-VSW"
      cidr = "192.168.15.0/24"
      az   = "" # Not requied to Define the AZ here as this value will be dynamically chosen with NATGW eligible zone
      desc = "DMZ Subnet for Hosting VM's with EIP/PIP and NATGW"
      tags = {
        role = "DMZ" ## Do not Remove DMZ tag, this string is being referenced in AZ variable will be replaced dynamically
      }
    }
  }
}

tags = {
  deployedBy = "Lumen"
}
```

Call the module as below in your preferred `main.tf` file

```hcl
  # Import the Azure ENV Variables or use Az Login
  backend "azurerm" {
    resource_group_name  = "lmn-sg-ops-rg"
    storage_account_name = "lmnapacops"
    container_name       = "tfstates"
    key                  = "alicloud/BRNTAG/regional/sg-mdls/01-VPC/terraform.tfstate"
  }
}

provider "alicloud" {
  # Configuration options
  region = var.region
}

module "vpc" {
  source     = "../../../modules/ali_vpc/"
  region     = var.region
  vpc_config = var.vpc_config
  tags       = local.tags
}

locals {
  tags = merge(try(var.tags, {}), { tf_dir = "${basename(dirname(abspath(path.root)))}/${basename(abspath(path.root))}" })
}
```