#vpc_key_regex = "^.*SG.*VPC$"
region = "ap-southeast-1"
vpc_tfstate_ds = {
  rg_name   = "lmn-sg-ops-rg"
  strg_name = "lmnapacops"
  cntr_name = "tfstates"
  key_path  = "alicloud/BRNTAG/regional/Singapore/01-VPC/terraform.tfstate"
}

vpc_id = ""

ecs_config = {
  dry_run           = false
  vswitch_key_regex = "^BRNTG-SNET-Z1A-VSW"
  name_pattern      = "ac-sg-ecs-sap"
  num_instances     = 2
  instance_type     = "ecs.t5-lc1m2.small"
  sec_grps          = ["sg-t4nijrvu2s38oiz6hk9e"]
  image_id          = "ubuntu_20_04_x64_20G_alibase_20200914.vhd"
  password          = "Admin12345!"
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
