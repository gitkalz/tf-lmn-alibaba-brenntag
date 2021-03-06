variable "region" {
   type = string
   description = "Enter the Region"
}

variable "vpc_config" {
  description = "A object representation of VPC and Subnets to be Deployed"
}

variable "tags" {
  type        = map
  description = "(optional) describe your variable"
}
