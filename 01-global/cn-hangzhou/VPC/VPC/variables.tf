variable "subnets" {
  type        = map
  description = "(optional) describe your variable"
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
    location = "singapore"
    module   = basename(abspath(path.module))
  }
}