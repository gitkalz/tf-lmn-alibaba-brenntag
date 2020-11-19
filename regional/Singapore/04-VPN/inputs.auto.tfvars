region = "ap-southeast-1"
vpn_config = {
  vgw_name         = "BRNTG-SG-01-VPNGW"                                                                        #Enter the Name of the VPN Gateway to be assigned
  vgw_desc         = "VPN Gateway"                                                                                         #(Optional) Enter the description for VPN Gateway Purpose ENV etc
  cgw_name         = "BRNTG-SG-01-CGW"                                                                          #Customer GW configuration name
  cgw_desc         = "Customer Gateway"                                                                                         # (Optional) Enter the Description of CGW Configuration
  cgw_ip           = "42.14.23.15"                                                                              # Mandatory - Customer Side Public IP Address for IPSec Connection
  conn_name        = "TO-BRNTG-SG-CONN"                                                                        #On-Prem Connection Name - Include Country-Facility/Building name for ease of troubleshooting
  cloud_subnets    = "172.31.31.0/24"                                                                           # Enter the comma saperated CIDR for Cloud Side Supernet or Subnets to permit routes
  customer_subnets = "192.168.31.0/24"                                                                          # Enter the comma saperated CIDR for Customer/Branch Side Supernet or Subnets to permit routes
  sg_psk           = "Hlrc215L8MVGoReEuK/AJTtrlN8uDPSoEtBM6xyiy64OTYlp3DmeAoQB/zYTQdIt4i1EJkrN7Sqyc8ylU54muQ==" # Preshared Key String - Ideal to be retrieved from Secrets Vault
}
vpc_tfstate_ds = {
    rg_name  = "lmn-sg-ops-rg"
    strg_name = "lmnapacops"
    cntr_name = "tfstates"
    key_path  = "alicloud/BRNTAG/regional/Singapore/01-VPC/terraform.tfstate"
}
