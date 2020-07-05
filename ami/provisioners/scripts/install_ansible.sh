#!/bin/bash -eux

# Install EPEL repository.
sudo yum update -y

# Install Ansible.
sudo pip3 install ansible
