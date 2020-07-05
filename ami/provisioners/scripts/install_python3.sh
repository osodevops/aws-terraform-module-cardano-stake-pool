#!/bin/bash -eux

sudo yum update -y

# Install Python 3.
sudo yum -y install python3

#used by some depends in Ansible
sudo ln -s /bin/pip3 /usr/local/bin/pip3

# # Update etc profile.d directory with the new path
# sudo echo 'export PATH=$PATH:/usr/local/bin/' > /etc/profile.d/sh.local
# sudo source /etc/profile.d/sh.local