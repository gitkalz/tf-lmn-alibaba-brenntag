variable "vpc_id" {
  type        = string
  description = "Change the default null to the VPC ID if you want to explicitly define"
  validation {
    condition     = length(var.vpc_id) > 4 && substr(var.vpc_id, 0, 4) == "vpc-"
    error_message = "The VPC_ID value must be a valid VPC id, starting with \"vpc-\"."
  }
}

variable "region" {
  type        = string
  description = "AliCloud Region in which you plan to deploy the resources"
}


variable "secgrps_config" {
  description = "Change the default null to the VPC ID if you want to explicitly define"
  default     = null
}


variable "tags" {
  type        = map
  description = "(optional) describe your variable"
  default = {}
}
