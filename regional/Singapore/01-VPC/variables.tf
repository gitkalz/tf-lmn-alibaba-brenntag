variable "subnets" {
  type        = map
  description = "(optional) describe your variable"
}

variable "region" {
  type        = string
  description = "AliCloud Region in which you plan to deploy the resources"
}

variable "vpc" {
    type = map
    description = "(optional) describe your variable"
}

variable "tags" {
    type = map
    description = "(optional) describe your variable"
}

locals {
  tags = {
    region = data.alicloud_regions.current_region_ds.regions.0.id
    tf-dir = basename(dirname(abspath(path.module)))
    tf-module   = basename(abspath(path.module))
  }
}