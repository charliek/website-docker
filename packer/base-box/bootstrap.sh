#!/bin/bash

set -x

CHEFDIR="/opt/chef-solo" 
CHEFSOLO="/usr/bin/chef-solo"
CHEF_KEY="/tmp/encrypted_data_bag_secret"

# update the only the first time through
sudo apt-get -y update

# Install Chef
sudo apt-get -y install build-essential
sudo apt-get -y install git
sudo apt-get -y install curl libxml2-dev libxslt-dev
sudo apt-get -y install vim emacs htop

curl -L https://www.opscode.com/chef/install.sh | sudo bash
  
sudo /opt/chef/embedded/bin/gem source --add https://rubygems.org/

# Setup librarian which is used to download cookbooks
sudo /opt/chef/embedded/bin/gem install librarian-chef

# Setup Chef Solo
sudo mkdir -p $CHEFDIR/cache

# Remove chef client service so it does not run unless told
if [ -f '/var/run/chef/client.pid' ] ; then
  sudo service chef-client stop
fi;

if [ -f '/etc/init.d/chef-client' ] ; then
  sudo rm /etc/init.d/chef-client
fi;

# setup  provision directory for init helpers
sudo mkdir -p /opt/provision
sudo chmod 777 /opt/provision
