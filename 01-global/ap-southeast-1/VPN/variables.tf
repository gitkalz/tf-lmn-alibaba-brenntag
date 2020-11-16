variable "vpc_id" {
    type = string
    description = "(optional) describe your variable"
    default = ""
}

variable "vgw_name" {
    type = string
    description = "(optional) describe your variable"
    default = "BRNTG-SG-01-VPNGW"
}

variable "cgw_name" {
    type = string
    description = "(optional) describe your variable"
    default = "BRNTG-SG-01-CGW"
}

variable "conn_name" {
    type = string
    description = "(optional) describe your variable"
    default = "TO-BRNTG-SG-CONN"
}