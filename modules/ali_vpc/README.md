# Alibaba Cloud VPC Module with Subnets
_Author: Kalyan Chakravarthi_
_Tested Date: 2 Dec 2020_

##### Sample input.auto.tfvars as shown below

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

##### Call the module as below in your preferred `main.tf` file

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

##### Insert the following variables required for the module in your `variables.tf` file

```hcl
variable "region" {
  type        = string
  description = "AliCloud Region in which you plan to deploy the resources"
}

variable "vpc_config" {
  description = "A object representation of VPC and Subnets to be Deployed"
}

variable "tags" {
  type        = map
  description = "(optional) describe your variable"
}

```

##### Outputs extracted from the module in `outputs.tf` file

```hcl
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

output "subnets_list" {
  value = flatten([for keys,items in module.vpc.subnets: {
        "${items.name}" = {
          "id" = items.id
          "ip_cidr" = items.cidr_block
          "zone" = items.availability_zone
          "description" = items.description
          }
      }])
}
```

Example Outputs as below

```
deployed_in = ap-southeast-1
subnets_list = [
  {
    "BRNTG-SNET-DMZ-VSW" = {
      "description" = "DMZ Subnet for Hosting VM's with EIP/PIP and NATGW"
      "id" = "vsw-t4n1bhyhui9b3fqc4g1x7"
      "ip_cidr" = "192.168.15.0/24"
      "zone" = "ap-southeast-1a"
    }
  },
  {
    "BRNTG-SNET-Z1A-VSW" = {
      "description" = "Subnet in Zone 1A Singapore"
      "id" = "vsw-t4n8kn9heexscvrsiwpge"
      "ip_cidr" = "192.168.12.0/24"
      "zone" = "ap-southeast-1a"
    }
  },
  {
    "BRNTG-SNET-Z1B-VSW" = {
      "description" = "Subnet in Zone 1B Singapore"
      "id" = "vsw-t4n6d7b29m91kw6xozdjw"
      "ip_cidr" = "192.168.13.0/24"
      "zone" = "ap-southeast-1b"
    }
  },
  {
    "BRNTG-SNET-Z1C-VSW" = {
      "description" = "Subnet in Zone 1C Singapore"
      "id" = "vsw-t4ni6lbedg6reoxnqfcyj"
      "ip_cidr" = "192.168.14.0/24"
      "zone" = "ap-southeast-1c"
    }
  },
]
vpc_id = vpc-t4nmcq1s0ych2aoa7335k
vpc_name = BRNTG-SG-SAP-VPC
your_account_ID = 5315904024020711
```