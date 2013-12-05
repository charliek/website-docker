#!/bin/bash

set -x

cd "$( dirname "${BASH_SOURCE[0]}" )"
rm chef-setup.tar.gz
pushd ..
tar zcvf packer/chef-setup.tar.gz chef util
popd
