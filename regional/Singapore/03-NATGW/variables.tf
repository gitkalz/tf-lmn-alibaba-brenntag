variable "vpc_id" {
  type        = string
  description = "(optional) describe your variable"
  default     = ""
}
variable "region" {
  type        = string
  description = "AliCloud Region in which you plan to deploy the resources"
}
variable "natgw_config" {
    type = map
    description = "Config map for Nat Gateway Input Variables"
}

variable "vpc_tfstate" {
    type = map
    description = "Enter the TF_State Location for VPC details"
}
