#!/bin/bash

set -x

packer build -var-file=env.json build.json
