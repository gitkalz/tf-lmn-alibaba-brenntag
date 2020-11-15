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
