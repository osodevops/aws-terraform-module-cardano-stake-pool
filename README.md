
<!-- markdownlint-disable -->
# Cardano Stake Pool Terraform module for AWS


<!-- markdownlint-restore -->

[![README Header][readme_header_img]][readme_header_link]

<!--




  ** DO NOT EDIT THIS FILE
  **
  ** This file was automatically generated by the `build-harness`.
  ** 1) Make all changes to `README.yaml`
  ** 2) Run `make init` (you only need to do this once)
  ** 3) Run`make readme` to rebuild this file.
  **
  ** (We maintain HUNDREDS of open source projects. This is how we maintain our sanity.)
  **





-->
Prodcution ready Terraform module to deploy a HA Cardano Stake Pool on AWS

---






## Usage

There are three sections to this module:
1) Creating the AMI (Amazon Machine Image) which is contains the binaries and default configuration for starting a relay and block producing (Core) node.
2) Relay and Core configuration / topology files which are managed by Terraform.
3) Creating both Relay and Core nodes inside separate [AWS Autoscaling group](https://aws.amazon.com/autoscaling/) which ensure there is always at least one Relay and Core instance running.




## Examples

### Packer AMI builder variables
Three variables are required for the `ami/vars/cardano-node-vars.json` file:
  ```yaml
      "packer_build_vpc_id": "vpc-xxxxxxx",
      "packer_build_subnet_id": "subnet-xxxxxx",
      "ami_users":"xxxxxxx",
  ```
  These values will be specefic to the AWS account.
    - `packer_build_vpc_id` VPC ID of the region to build
    - `packer_build_subnet_id` Subnet ID of the region to build
    - `ami_users` AWS Account ID where you want to run AMI

  ### Build command for AWS
  ```aws-vault exec <<aws-profile>> -- packer build -var-file="./ami/vars/cardano-node-vars.json" "./ami/packfiles/cardano-node.json"```

  ### Local development
  To build Cardano node and CLI locally via the Ansible playbook you can run thhe following commands
  ```
    cd ami/ && vagrant up
  ```





## Related Projects

Check out these related projects.

- [Cardano Ansible role](https://github.com/osodevops/ansible-role-cardano-node) - Ansible role for the provisioning of Shelly Cardano binaries from source



## Need some help

File a GitHub [issue](https://github.com/osodevops/aws-terraform-module-cardano-stake-pool/issues), send us an [email][email] or [tweet us][twitter].

## The legals

Copyright © 2017-2021 [OSO](https://oso.sh) | See [LICENCE](LICENSE) for full details.

[<img src="https://oso-public-resources.s3.eu-west-1.amazonaws.com/oso-logo-green.png" alt="OSO who we are" width="250"/>](https://oso.sh/who-we-are/)

## Who we are

We at [OSO][website] help teams to adopt emerging technologies and solutions to boost their competitiveness, operational excellence and introduce meaningful innovations that drive real business growth. Our developer-first culture, combined with our cross-industry experience and battle-tested delivery methods allow us to implement the most impactful solutions for your business.

Looking for support applying emerging technologies in your business? We’d love to hear from you, get in touch by [email][email]

Start adopting new technologies by checking out [our other projects][github], [follow us on twitter][twitter], [join our team of leaders and challengers][careers], or [contact us][contact] to find the right technology to support your business.[![Beacon][beacon]][website]

  [logo]: https://oso-public-resources.s3.eu-west-1.amazonaws.com/oso-logo-green.png
  [website]: https://oso.sh?utm_source=github&utm_medium=readme&utm_campaign=osodevops/aws-terraform-module-cardano-stake-pool&utm_content=website
  [github]: https://github.com/osodevops?utm_source=github&utm_medium=readme&utm_campaign=osodevops/aws-terraform-module-cardano-stake-pool&utm_content=github
  [careers]: https://oso.sh/careers/?utm_source=github&utm_medium=readme&utm_campaign=osodevops/aws-terraform-module-cardano-stake-pool&utm_content=careers
  [contact]: https://oso.sh/contact/?utm_source=github&utm_medium=readme&utm_campaign=osodevops/aws-terraform-module-cardano-stake-pool&utm_content=contact
  [linkedin]: https://www.linkedin.com/company/oso-devops?utm_source=github&utm_medium=readme&utm_campaign=osodevops/aws-terraform-module-cardano-stake-pool&utm_content=linkedin
  [twitter]: https://twitter.com/osodevops?utm_source=github&utm_medium=readme&utm_campaign=osodevops/aws-terraform-module-cardano-stake-pool&utm_content=twitter
  [email]: mailto:enquiries@oso.sh?utm_source=github&utm_medium=readme&utm_campaign=osodevops/aws-terraform-module-cardano-stake-pool&utm_content=email
  [readme_header_img]: https://oso-public-resources.s3.eu-west-1.amazonaws.com/oso-animation.gif
  [readme_header_link]: https://oso.sh/what-we-do/?utm_source=github&utm_medium=readme&utm_campaign=osodevops/aws-terraform-module-cardano-stake-pool&utm_content=readme_header_link
  [beacon]: https://github-analyics.ew.r.appspot.com/G-WV0Q3HYW08/osodevops/aws-terraform-module-cardano-stake-pool?pixel&cs=github&cm=readme&an=aws-terraform-module-cardano-stake-pool
