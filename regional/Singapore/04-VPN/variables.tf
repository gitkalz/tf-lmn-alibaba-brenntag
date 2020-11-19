variable "vpc_id" {
  type        = string
  description = "Ideally this is pulled from VPC outputs, if not state it here"
  default     = ""
}

variable "region" {
  type        = string
  description = "AliCloud Region in which you plan to deploy the resources"
}

variable "vpn_config" {
  type        = map
  description = "Configure the map object to insert the key inputs"
}

variable "vpc_tfstate_ds" {
    type = map
    description = "Enter the TF_State Location for VPC details"
}