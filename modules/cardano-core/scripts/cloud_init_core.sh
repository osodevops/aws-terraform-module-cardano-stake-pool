#!/bin/bash -x

hostnamectl set-hostname ${hostname_prefix}${count}.${private_dns_zone}

# Log output from this user_data script.
exec > >(tee /var/log/user-data.log|logger -t user-data ) 2>&1

echo "#Update start script with port and remove default host-addr as we use topology"
sed -i "/0.0.0.0/d" /opt/cardano/cnode/scripts/start-node.sh
sed -i "s/3000/${core_node_port}/g" /opt/cardano/cnode/scripts/start-node.sh

echo "#Update config configuration with production values."
CONFIG_FILE=`find /opt/cardano/cnode/configuration -maxdepth 1 -name "*-config*" -print`
echo "${config_file}" > $CONFIG_FILE

echo "#Update topology configuration with relay nodes."
TOPOLOGY_FILE=`find /opt/cardano/cnode/configuration -maxdepth 1 -name "*-topology*" -print`
echo "${topology_file}" > $TOPOLOGY_FILE

# Start and enable the service at startup
sudo systemctl start cardano
sudo systemctl enable cardano