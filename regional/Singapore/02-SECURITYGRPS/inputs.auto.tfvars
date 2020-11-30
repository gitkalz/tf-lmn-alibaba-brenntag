region = "ap-southeast-1"

vpc_tfstate_ds = {
  rg_name   = "lmn-sg-ops-rg"
  strg_name = "lmnapacops"
  cntr_name = "tfstates"
  key_path  = "alicloud/BRNTAG/regional/Singapore/01-VPC/terraform.tfstate"
}

vpc_id = ""

secgrps = {
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