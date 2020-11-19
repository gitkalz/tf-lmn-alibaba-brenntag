variable "vpc_id" {
  type        = string
  description = "Change the default null to the VPC ID if you want to explicitly define"
  default     = null
}

variable "vsw_id" {
  type        = string
  description = "Change the default null to the vSWITCH ID if you want to explicitly define"
  default     = null
}

variable "region" {
  type        = string
  description = "AliCloud Region in which you plan to deploy the resources"
}
variable "natgw_config" {
  type        = map
  description = "Config map for Nat Gateway Input Variables"
}

variable "vpc_tfstate_ds" {
  type        = map
  description = "Enter the TF_State Location for VPC details"
}
