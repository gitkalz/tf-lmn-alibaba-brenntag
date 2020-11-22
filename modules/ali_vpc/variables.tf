variable "region" {
   type = string
   description = "Enter the Region"
}
variable "subnets" {
  type        = map
  description = "(optional) describe your variable"
}

variable "vpc" {
  type        = map
  description = "(optional) describe your variable"
}

variable "tags" {
  type        = map
  description = "(optional) describe your variable"
}

locals {
  tags = {
    location = data.alicloud_regions.current_region_ds.regions.0.id
    module   = basename(abspath(path.module))
  }
}

