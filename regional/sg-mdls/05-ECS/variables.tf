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

variable "instance_password" {
  type = string
  description = "Enter the root/administrator password for the instance"
}

variable "vswitch_id_regex" {
  type = string
  description = "Regex pattern to search for the VSwitch name and find the id"
}

variable "tags" {
  type        = map(string)
  description = "Enter the vSwitch name where you want to deploy the Virtual Machines on"
  default     = {}
}