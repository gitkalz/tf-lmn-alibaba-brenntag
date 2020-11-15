terraform {
  required_providers {
    alicloud = {
      source  = "aliyun/alicloud"
      version = "1.103.1"
    }
  }
  # backend "oss" {
  #   bucket              = "terraform-remote-backend-610e1c11-151f-2c5c-1fac-0638b0bca79a"
  #   prefix              = "env:"
  #   key                 = "lab/terraform.tfstate"
  #   acl                 = "private"
  #   region              = "ap-southeast-1"
  #   encrypt             = "true"
  #   tablestore_endpoint = "https://tf-oss-kalz.ap-southeast-1.ots.aliyuncs.com"
  #   tablestore_table    = "ali_ts_tf_01"
  # }
}

provider "alicloud" {
  # Configuration options
}
