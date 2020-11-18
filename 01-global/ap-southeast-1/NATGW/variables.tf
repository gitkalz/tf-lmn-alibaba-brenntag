variable "vpc_id" {
  type        = string
  description = "(optional) describe your variable"
  default     = ""
}
variable "region" {
  type        = string
  description = "AliCloud Region in which you plan to deploy the resources"
}
variable "natgw_name" {
    type = string
    description = "(optional) describe your variable"
    default = "BRNTG-SG-NATGW"
}

variable "natgw_spec" {
    type = string
    description = "(optional) describe your variable"
    default = "Small"
}

variable "vsw_id" {
    type = string
    description = "(optional) describe your variable"
    default = ""
}