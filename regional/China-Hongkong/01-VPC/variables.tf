variable "region" {
  type        = string
  description = "AliCloud Region in which you plan to deploy the resources"
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
    location = "hongkong"
    module   = basename(abspath(path.module))
  }
}

