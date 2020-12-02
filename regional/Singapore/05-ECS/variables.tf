variable "region" {
  type        = string
  description = "AliCloud Region in which you plan to deploy the resources"
}

variable "vpc_tfstate_ds" {
  type        = map
  description = "Enter the TF_State Location for VPC details"
}


variable "ecs_config" {
  description = "An Object representation for ECS Config"
}

variable "vsw_id" {
  type        = string
  description = "Enter the vSwitch name where you want to deploy the Virtual Machines on"
  default     = ""
}