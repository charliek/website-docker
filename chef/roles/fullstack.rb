name "Install the full application"
description "Install stack including database, etcd, and migrations"

# TODO this was not working. Should put most of the vagrant-json file into here.

default_attributes :etcd => {
        :version => "0.2.0",
        :sha256 => "8df0e87663eb3f5dfe00362c9afe4eab192f0358a7c9278223e81c6d08898e55"
	}

run_list "recipe[etcd]"
