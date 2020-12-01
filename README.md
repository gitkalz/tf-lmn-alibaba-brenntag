# tf-lmn-alibaba-brenntag

- Added Azure Backend
- Updated the folder Skeleton

```
China (Hangzhou)	Hangzhou	cn-hangzhou	8
China (Shanghai)	Shanghai	cn-shanghai	7
Singapore (Singapore)	Singapore	ap-southeast-1	3
```

Naming Convention Ideas
<cust>-<env>-<region>-vpc
<cust>-<env>-<az>-0#-vsw

Launch-templates <name>-lt
SecurityGroup - <cust>-<env>-sg
OSS - <cust><reg><0xx><purpose>bkt
iam group - <name>-iam-group

VPC Peering Link	{{account_naming_construct_of_target}} - {{scope_of_target}} - vpc-peerlink
Route Tables	{{account_naming_construct}} - {{routeType}} - rt  [[-  zone]]  Route type is one of the following:

public
private

{{account_name_construct}} - {{subnetType}} - {{routeType}} - {{az}} - {{number}}

Subnet Type should be one of:

app

elb

db

cache

nat

web

data
Number:

Starts at 1, only increments if we have outgrown that AZ’s subnet


```
 + az  = [                                                                                                                                                                      
      + "cn-hangzhou-b",                                                                                                                                                         
      + "cn-hangzhou-e",                                                                                                                                                         
      + "cn-hangzhou-f",                                                                                                                                                         
      + "cn-hangzhou-g",                                                                                                                                                         
      + "cn-hangzhou-h",                                                                                                                                                         
      + "cn-hangzhou-i",                                                                                                                                                         
      + "cn-hangzhou-j",                                                                                                                                                         
    ] 

NATGW ENhanced Zones
          ~ {
              > "华东 1 可用区 H"
              "cn-hangzhou-h"
            }
          ~ {
              > "华东 1 可用区 I"
              "cn-hangzhou-i"
            }
```

Enable following Services
KMS
ECS
OSS
HBR
VPC
NATGW
VPN

Create a DMZ Subnet to Host VM's with Public IP's and NAT GW.. Also ensure the Availability Zone of the Subnet/VSW support the NATGW Deployment

#### REGEX Matches
^.*DMZ.*VSW$ -> Matches any word containing DMZ and ending with VSW ie .. BRNTG-SNET-DMZ-VSW
^.*Z1A.*VSW$ -> Matches any word containing Z1A and ending with VSW ie .. BRNTG-SNET-Z1A-VSW

#### API Disk mapping to Portal Names
ESSD = cloud_essd
Standard SSD = cloud_ssd
Ultra disk = cloud_efficiency
Basic disk  = cloud