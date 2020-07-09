# Aws Terraform Module Cardano Stake Pool
A Terraform module to deploy a HA Cardano Stake Pool on AWS

There are three sections to this module:
1) Creating the AMI (Amazon Machine Image) which is contains the binaries and default configuration for starting a relay and block producing (Core) node.
2) Relay and Core configuration / topology files which are managed by Terraform.
3) Creating both Relay and Core nodes inside separate [AWS Autoscaling group](https://aws.amazon.com/autoscaling/) which ensure there is always at least one Relay and Core instance running. 
### Packer AMI builder

## Packer variables
Three variables are required for the `ami/vars/cardano-node-vars.json` file:

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
To build Cardano node and CLI locally via the Ansible playbook you can run thhe following commands
    cd ami/ && vagrant up
