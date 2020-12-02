# Alibaba Cloud Security Groups Module
_Author: Kalyan Chakravarthi_
_Tested Date: 2 Dec 2020_

##### Sample input.auto.tfvars as shown below

```hcl
region = "ap-southeast-1"

vpc_id = ""

vpc_name_regex = "^.*SG.*VPC$" # if VPC id is not defined, then this variable can be used for VPC Search

secgrps_config = {
  allow_rdp_ssh = [
    {
      type        = "ingress"
      ip_protocol = "tcp"
      policy      = "accept"
      port_range  = "3389/3389"
      cidr_ip     = "0.0.0.0/0"
    },
    {
      type        = "ingress"
      ip_protocol = "tcp"
      policy      = "accept"
      port_range  = "22/22"
      cidr_ip     = "0.0.0.0/0"
    },
    {
      type        = "ingress"
      ip_protocol = "icmp"
      policy      = "accept"
      port_range  = "-1/-1"
      cidr_ip     = "0.0.0.0/0"
    }
  ]
  allow_ssh = [
    {
      type        = "ingress"
      ip_protocol = "tcp"
      policy      = "accept"
      port_range  = "22/22"
      cidr_ip     = "0.0.0.0/0"
    },
    {
      type        = "ingress"
      ip_protocol = "icmp"
      policy      = "accept"
      port_range  = "-1/-1"
      cidr_ip     = "0.0.0.0/0"
    }
  ]
}
```
##### Call the module as below in your preferred `main.tf` file

```hcl
terraform {
  required_providers {
    alicloud = {
      source  = "aliyun/alicloud"
      version = "~> 1.105.0"
    }
  }
  # Import the Azure ENV Variables or use Az Login
  backend "azurerm" {
    resource_group_name  = "lmn-sg-ops-rg"
    storage_account_name = "lmnapacops"
    container_name       = "tfstates"
    key                  = "alicloud/BRNTAG/regional/sg-mdls/02-SecGrps/terraform.tfstate"
  }
}

provider "alicloud" {
  # Configuration options
  region = var.region
}

data "alicloud_vpcs" "vpcs_ds" {
  status     = "Available"
  name_regex = var.vpc_name_regex
}

module "secgrps" {
  source  = "../../../modules/ali_secgrps/"
  region  = var.region
  secgrps_config = var.secgrps_config
  vpc_id = local.vpc_id
  tags    = local.tags
}

locals {
  tags = merge(try(var.tags, {}), { tf_dir = "${basename(dirname(abspath(path.root)))}/${basename(abspath(path.root))}" })
  vpc_id = (var.vpc_id != "" && var.vpc_id != null) ? var.vpc_id  : try(data.alicloud_vpcs.vpcs_ds.ids.0,null)
}
```

##### Insert the following variables required for the module in your `variables.tf` file

```hcl
variable "vpc_id" {
  type        = string
  description = "Change the default null to the VPC ID if you want to explicitly define"
  default     = null
}

variable "region" {
  type        = string
  description = "AliCloud Region in which you plan to deploy the resources"
}


variable "secgrps_config" {
  description = "Change the default null to the VPC ID if you want to explicitly define"
  default     = null
}

variable "vpc_name_regex" {
  type = string
  description = "Enter the Regex to match the VPC Name in which you plan to create security Groups"
}

variable "tags" {
  type        = map
  description = "(optional) describe your variable"
  default = {}
}

```
##### Outputs extracted from the module in `outputs.tf` file

```hcl

output "sg_grps" {
  value = module.secgrps.sg_grps
  }

output "sg_rules" {
  value = module.secgrps.sg_rules
}

output "vpc_id" {
  value = module.secgrps.vpc_id
}
```

Example Outputs as below
```
Outputs:                                                                                                                                                                         
                                                                                                                                                                                 
sg_grps = {                                                                                                                                                                      
  "allow_rdp_ssh" = "sg-t4nh8vajxj1eti99flry"                                                                                                                                    
  "allow_ssh" = "sg-t4nh3bdea4payibih41d"                                                                                                                                        
}                                                                                                                                                                                
sg_rules = {                                                                                                                                                                     
  "allow_rdp_ssh" = {                                                                                                                                                            
    "sg-t4nh8vajxj1eti99flry" = [
      "sg-t4nh8vajxj1eti99flry:ingress:icmp:-1/-1::0.0.0.0/0:accept:1",
      "sg-t4nh8vajxj1eti99flry:ingress:tcp:22/22::0.0.0.0/0:accept:1",
      "sg-t4nh8vajxj1eti99flry:ingress:tcp:3389/3389::0.0.0.0/0:accept:1",
    ]
  }
  "allow_ssh" = {
    "sg-t4nh3bdea4payibih41d" = [
      "sg-t4nh3bdea4payibih41d:ingress:icmp:-1/-1::0.0.0.0/0:accept:1",
      "sg-t4nh3bdea4payibih41d:ingress:tcp:22/22::0.0.0.0/0:accept:1",
    ]
  }
}
vpc_id = vpc-t4nmcq1s0ych2aoa7335k
```