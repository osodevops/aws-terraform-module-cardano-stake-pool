#!/bin/bash
echo "Installing AWS CLI"

sudo yum install -y unzip

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
rm awscliv2.zip
sudo ./aws/install