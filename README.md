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

Kitchen Tests (Broken):

TODO need to get this working. My current plan is to restructure the repo quite a bit, so much change is coming.

```bash
cd chef
bundle install
bundle exec kitchen test  # to run all tests
bundle exec kitchen list  # to lists tests
bundle exec kitchen converge blog-full-precise64 # To run individual test
bundle exec kitchen destroy  # to destroy test instances
```
