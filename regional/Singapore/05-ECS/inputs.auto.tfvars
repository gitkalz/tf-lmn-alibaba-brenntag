#vpc_key_regex = "^.*SG.*VPC$"
region = "ap-southeast-1"

vpc_tfstate_ds = {
  rg_name      = "lmn-sg-ops-rg"
  strg_name    = "lmnapacops"
  cntr_name    = "tfstates"
  tfstate_path = "alicloud/BRNTAG/regional/Singapore/02-SECURITYGRPS/terraform.tfstate"
}

vsw_id = "vsw-t4ntkf4frbd2euino7243" #Ideal to lookup this value from console/vpc outputs and input here, if not enter the RegEx

ecs_config = {
  dry_run              = false
  vswitch_key_regex    = "^.*Z1B.*VSW$" # if value not stated in vsw_id, then this regex key will used to lookup for the secrets in KMS
  name_pattern         = "ac-sg-ecs-sap"
  num_instances        = 2
  instance_type        = "ecs.t5-lc1m2.small"
  sec_grps             = ["sg-t4nexjvl0tb2uk8zctls", "sg-t4n7lz80kp72kmhbx6pu"] # Enter the Names, not secgrp id's.. Dont input empty elements, names read from SECURITYGROUPS Module Outputs
  image_id             = "ubuntu_20_04_x64_20G_alibase_20200914.vhd"
  password             = "Admin12345!"
  instance_charge_type = "PostPaid"
  tags = {
    purpose = "sap"
  }
  data_disks = {
    "0" = {
      size                 = "20"
      category             = "cloud_efficiency"
      delete_with_instance = true
    }
    "1" = {
      size                 = "40"
      category             = "cloud_efficiency"
      delete_with_instance = true
    }
  }

}
