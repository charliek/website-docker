#!/bin/bash

set -x

. build_tar.sh
packer build -var-file="$HOME/.packer/env.json" -only=amazon-ebs build.json
