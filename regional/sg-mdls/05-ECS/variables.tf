variable "region" {
  type        = string
  description = "AliCloud Region in which you plan to deploy the resources"
}

variable "ecs_config" {
  description = "An Object representation for ECS Config"
}

variable "vswitch_id" {
  type        = string
  description = "Enter the vSwitch name where you want to deploy the Virtual Machines on"
}


variable "num_instances" {
  type        = number
  description = "Enter the number of ECS Instances your want to deploy"
}



variable "tags" {
  type        = map(string)
  description = "Enter the vSwitch name where you want to deploy the Virtual Machines on"
  default     = {}
}