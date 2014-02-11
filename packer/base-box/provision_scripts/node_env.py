#!/usr/bin/env python
import json
import sys
import os
import codecs

if len(sys.argv) != 4:
    sys.exit('Usage: %s [environment] [in file] [out file]' % sys.argv[0])

solo_env = sys.argv[1]
in_file = sys.argv[2]
out_file = sys.argv[3]

solo_json = None
with codecs.open(in_file, 'r', 'utf-8') as fp:
    solo_json = fp.read()

    # Replace the environment variable placeholders
    for k, v in os.environ.items():
    	solo_json = solo_json.replace("${"+k+"}", v)

with codecs.open(out_file, 'w', 'utf-8') as fp:
	fp.write(solo_json)
