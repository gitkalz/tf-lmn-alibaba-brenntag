region = "ap-southeast-1"

vpc_tfstate_ds = {
  rg_name   = "lmn-sg-ops-rg"
  strg_name = "lmnapacops"
  cntr_name = "tfstates"
  key_path  = "alicloud/BRNTAG/regional/Singapore/01-VPC/terraform.tfstate"
}

natgw_config = {
  natgw_name = "BRNTG-SG-NATGW"
  natgw_desc = "NAT Gateway for Singapore SAP VPC"
  natgw_spec = "Small"
  vsw_id     = "" # Optional
}
