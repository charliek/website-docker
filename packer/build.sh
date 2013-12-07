#!/bin/bash

set -x

. build_tar.sh
packer build -var-file=env.json build.json
