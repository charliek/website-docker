#!/bin/bash

set -x

packer build -var-file="$HOME/.packer/env.json" -only=amazon-instance base-box.json
