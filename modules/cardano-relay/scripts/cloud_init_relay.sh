#!/bin/bash -x

# Log output from this user_data script.
exec > >(tee /var/log/user-data.log|logger -t user-data ) 2>&1

# Allow the instance to associate a static IP.
echo "#Associate instance with static IP"
aws ec2 associate-address --instance-id $(curl http://169.254.169.254/latest/meta-data/instance-id) --allocation-id ${eip} --allow-reassociation --region ${region}

echo "#Update node configuration"
sed -i "s/0.0.0.0/${eip_ip4}/g" /opt/cardano/cnode/scripts/start-node.sh
sed -i "s/3000/${relay_node_port}/g" /opt/cardano/cnode/scripts/start-node.sh

# Start and enable the service at startup
sudo systemctl start cardano
sudo systemctl enable cardano