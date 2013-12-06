#!/bin/bash

set -x

cd "$( dirname "${BASH_SOURCE[0]}" )"
rm chef-setup.tar.gz
pushd ..
tar zcvf packer/chef-setup.tar.gz chef/{Cheffile,Cheffile.lock,Gemfile,Gemfile.lock,data_bags,roles,site-cookbooks,solo-nodes} util
popd
