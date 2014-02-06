#!/bin/bash

set -x

sudo apt-get install -y ruby1.8 ruby1.8-dev make unzip build-essential rsync
sudo mkdir -p /opt/ec2-ami-tools
sudo chown -R ubuntu /opt/ec2-ami-tools
wget -r 3 -O /opt/ec2-ami-tools/ec2-ami-tools-1.4.0.9.zip http://charliek-tools.s3.amazonaws.com/ec2-ami-tools-1.4.0.9.zip
cd /opt/ec2-ami-tools
sudo unzip ec2-ami-tools-1.4.0.9.zip
sudo rm ec2-ami-tools-1.4.0.9.zip
sudo chown -R root /opt/ec2-ami-tools
sudo sync
