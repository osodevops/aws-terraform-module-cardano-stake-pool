#!/bin/bash -x

hostnamectl set-hostname ${hostname_prefix}${count}.${private_dns_zone}

# Log output from this user_data script.
exec > >(tee /var/log/user-data.log|logger -t user-data ) 2>&1

REGION=${region}

echo "#Associate instance with static IP"
aws ec2 associate-address --instance-id $(curl http://169.254.169.254/latest/meta-data/instance-id) --allocation-id ${eip} --allow-reassociation --region $REGION

echo "#Wait for instances in core ASG to become available"
while true
do
  ASG_INSTANCE_IDS=$(aws autoscaling describe-auto-scaling-groups --region $REGION --query "AutoScalingGroups[? Tags[? (Key=='Environment') && Value=='"${environment}"']] | [? Tags[? Key=='Node' && Value =='core']]".Instances[*].InstanceId  --output text)

  if [[ $ASG_INSTANCE_IDS ]]
  then
    echo "#Obtained instance details: $ASG_INSTANCE_IDS"
    break
  fi

  echo "#No instances available Sleeping for 1 minute"
  sleep 60
done

echo "#Populate template file"
cat << EOF > /tmp/topology.tmp
{
  "Producers": [
EOF

for instance in $ASG_INSTANCE_IDS
do
  INSTANCE_IP=$(aws ec2 describe-instances --instance-ids $instance --region $REGION --query 'Reservations[].Instances[].PrivateIpAddress'  --output text)

  cat << EOF >> /tmp/topology.tmp
    {
      "addr": "$INSTANCE_IP",
      "port": ${relay_node_port},
      "valency": 1
    },
EOF
done

cat << EOF >> /tmp/topology.tmp
    {
      "addr": "relays-new.cardano-testnet.iohkdev.io",
      "port": 3001,
      "valency": 2
    }
  ]
}
EOF

echo "#Update topology configuration with relay nodes"
TOPOLOGY_FILE=`find /opt/cardano/cnode/configuration -maxdepth 1 -name "*-topology*" -print`
mv /tmp/topology.tmp $TOPOLOGY_FILE

echo "#Update start script with port and remove default host-addr as we use topology"
sed -i "/0.0.0.0/d" /opt/cardano/cnode/scripts/start-node.sh
sed -i "s/3000/${relay_node_port}/g" /opt/cardano/cnode/scripts/start-node.sh

echo"#Start and enable Cardano"
sudo systemctl start cardano
sudo systemctl enable cardano