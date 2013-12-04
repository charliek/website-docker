#!/bin/bash

# This file is called on startup using the vagrant shell provisioner

# Emit an upstart event for scripts that must be started after vagrant is finished mounting.
initctl emit vagrant-mounted

sudo /opt/chef-solo/website/util/vagrant-bootstrap.sh /opt/chef-solo/website/chef/solo-nodes/blog-full.json
