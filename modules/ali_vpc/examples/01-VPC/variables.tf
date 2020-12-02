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

