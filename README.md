website-docker
------------
A project I am putting together to see what it looks like to build a machine using chef and docker together

[![Build Status](https://drone.io/github.com/charliek/website-chef/status.png)](https://drone.io/github.com/charliek/website-docker/latest)

Running Tests
=============

Foodcritic Analysis:

```bash
cd chef
bundle install
bundle exec foodcritic -f all site-cookbooks/
```

Kitchen Tests:

```bash
cd chef
bundle install

# List the currently running images
bundle exec kitchen list

# Login to one of the boxes that has been converged. Used for manual testing.
kitchen login default-ubuntu-1204

# Run chef and get a VM setup. Note that this will not tear down the VM
# and should be used for development.
bundle exec kitchen converge [blog-full-precise64]

# Run the tests for in the kitchen. Note that this will not tear down the VM
# and should be used for development.
bundle exec kitchen verify [blog-full-precise64]

# Destroy test instances that may be hanging around from the above commands
bundle exec kitchen destroy

# Run all tests and destroy the image after complete. Without the --destroy
# flag the vms would not get torn down on a test failure. Used mostly in 
# CI environments
bundle exec kitchen test --destroy 
```
