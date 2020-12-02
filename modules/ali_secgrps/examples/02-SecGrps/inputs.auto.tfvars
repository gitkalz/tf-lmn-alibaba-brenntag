region = "ap-southeast-1"

vpc_id = ""

vpc_name_regex = "^.*SG.*VPC$" # if VPC id is not defined, then this variable can be used for VPC Search

secgrps_config = {
  allow_rdp_ssh = [
    {
      type        = "ingress"
      ip_protocol = "tcp"
      policy      = "accept"
      port_range  = "3389/3389"
      cidr_ip     = "0.0.0.0/0"
    },
    {
      type        = "ingress"
      ip_protocol = "tcp"
      policy      = "accept"
      port_range  = "22/22"
      cidr_ip     = "0.0.0.0/0"
    },
    {
      type        = "ingress"
      ip_protocol = "icmp"
      policy      = "accept"
      port_range  = "-1/-1"
      cidr_ip     = "0.0.0.0/0"
    }
  ]
  allow_ssh = [
    {
      type        = "ingress"
      ip_protocol = "tcp"
      policy      = "accept"
      port_range  = "22/22"
      cidr_ip     = "0.0.0.0/0"
    },
    {
      type        = "ingress"
      ip_protocol = "icmp"
      policy      = "accept"
      port_range  = "-1/-1"
      cidr_ip     = "0.0.0.0/0"
    }
  ]
}