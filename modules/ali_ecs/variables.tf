variable "region" {
  type        = string
  description = "AliCloud Region in which you plan to deploy the resources"
}

variable "ecs_input_map" {
  # type = object({
  #   dry_run              = string
  #   vswitch_id           = string
  #   name_pattern         = string
  #   num_instances        = number
  #   instance_type        = string
  #   sec_grps             = list(string)
  #   image_id             = string
  #   tags                 = map(string)
  #   password             = string
  #   instance_charge_type = string
  #   data_disks = map(string)
  # })
  description = "An Object representation for ECS Config"
  validation {
    condition     = can(regex("^sg-", compact(var.ecs_input_map.sec_grp_ids)[0]))
    error_message = "The SecurityGroups value must be a valid id, starting with \"sg-\"."
  }
}

variable "vswitch_id" {
  type        = string
  description = "Enter the vSwitch name where you want to deploy the Virtual Machines on"
  validation {
    condition     = can(regex("^vsw-", var.vswitch_id))
    error_message = "The VSwitchID value must be a valid id, starting with \"vsw-\"."
  }
}


variable "num_instances" {
  type        = number
  description = "Enter the number of ECS Instances your want to deploy"
}

variable "instance_password" {
  type = string
  description = "Enter the root/administrator password for the instance"
}

variable "tags" {
  type        = map(string)
  description = "Enter the Tags with Name = value pairs you want to add"
  default     = {}
}