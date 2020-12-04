#vpc_key_regex = "^.*SG.*VPC$"
region = "ap-southeast-1"

# vpc_tfstate_ds = {
#   rg_name      = "lmn-sg-ops-rg"
#   strg_name    = "lmnapacops"
#   cntr_name    = "tfstates"
#   tfstate_path = "alicloud/BRNTAG/regional/Singapore/02-SECURITYGRPS/terraform.tfstate"
# }


vswitch_id           = "vsw-t4n9o3wgdgrpx72nvj9su"
num_instances = "1"

ecs_config = {
  dry_run              = false
  name_pattern         = "ac-sg-ecs-sap"
  instance_type        = "ecs.t5-lc1m2.small"
  sec_grp_ids             = ["", "sg-t4n0gaiewd2wyivh3ilc"] # Enter the SecurityGroup ID's
  image_id             = "ubuntu_20_04_x64_20G_alibase_20200914.vhd"
  password             = "Admin12345!"
  internet_max_bandwidth_out = "5" ## if anything greater than 0, a public IP will be assigned.
  instance_charge_type = "PostPaid"
  tags = {
    purpose = "sap"
  }
  data_disks = {
    "disk-0" = {
      size                 = "20"
      category             = "cloud_efficiency"
      delete_with_instance = true
    }
    "disk-1" = {
      size                 = "40"
      category             = "cloud_efficiency"
      delete_with_instance = true
    }
  }
}
