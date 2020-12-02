variable "vpc_id" {
  type        = string
  description = "Change the default null to the VPC ID if you want to explicitly define"
  default     = null
}

variable "region" {
  type        = string
  description = "AliCloud Region in which you plan to deploy the resources"
}


variable "secgrps_config" {
  description = "Change the default null to the VPC ID if you want to explicitly define"
  default     = null
}

variable "vpc_name_regex" {
  type = string
  description = "Enter the Regex to match the VPC Name in which you plan to create security Groups"
}

variable "tags" {
  type        = map
  description = "(optional) describe your variable"
  default = {}
}
