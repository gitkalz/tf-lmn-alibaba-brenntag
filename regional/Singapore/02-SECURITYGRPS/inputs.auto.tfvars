region = "ap-southeast-1"

vpc_tfstate_ds = {
  rg_name   = "lmn-sg-ops-rg"
  strg_name = "lmnapacops"
  cntr_name = "tfstates"
  key_path  = "alicloud/BRNTAG/regional/Singapore/01-VPC/terraform.tfstate"
}

secgrps = {
    allow_rdp = {
    type        = "ingress"
    ip_protocol = "tcp"
    nic_type    = "intranet"
    policy      = "accept"
    port_range  = "3389/3389"
    priority    = 1
    cidr_ip     = "0.0.0.0/0"
  }
  allow_ssh = {
    type        = "ingress"
    ip_protocol = "tcp"
    # nic_type    = "intranet"
    policy      = "accept"
    port_range  = "22/22"
    priority    = 1
    cidr_ip     = "0.0.0.0/0"
  }
  sec_grp1 = {
    type        = "ingress"
    ip_protocol = "tcp"
    nic_type    = "intranet"
    policy      = "drop"
    port_range  = "1/65535"
    priority    = 1
    cidr_ip     = "0.0.0.0/0"
  }
  sec_grp2 = {
    type        = "egress"
    ip_protocol = "tcp"
    nic_type    = "intranet"
    policy      = "accept"
    port_range  = "1/12345"
    priority    = 1
    cidr_ip     = "0.0.0.0/0"
  }
}