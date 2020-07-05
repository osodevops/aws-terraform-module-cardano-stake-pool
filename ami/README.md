### Packer AMI builder

## Packer variables
Three variables are required for the `cardano-node-vars.json` file:

    "packer_build_vpc_id": "vpc-xxxxxxx",
    "packer_build_subnet_id": "subnet-xxxxxx",
    "ami_users":"xxxxxxx",
    
These values will be specefic to the AWS account. 
- `packer_build_vpc_id` VPC ID of the region to build
- `packer_build_subnet_id` Subnet ID of the region to build
- `ami_users` AWS Account ID where you want to run AMI

### Build command for AWS
    aws-vault exec <<aws-profile>> -- packer build -var-file="./ami/vars/cardano-node-vars.json" "./ami/packfiles/cardano-node.json"

### Local development
    cd ami/ && vagrant up