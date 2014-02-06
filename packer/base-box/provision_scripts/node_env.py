#!/usr/bin/env python
import json
import sys

if len(sys.argv) != 3:
    sys.exit('Usage: %s [solo node] [environment]' % sys.argv[0])

solo_file = sys.argv[1]
solo_env = sys.argv[2]

solo_json = None
with open(solo_file, 'r') as fp:
    solo_json = json.load(fp)
    solo_json['blog']['environment'] = solo_env

with open(solo_file, 'w') as fp:
	json.dump(solo_json, fp, indent=2)
