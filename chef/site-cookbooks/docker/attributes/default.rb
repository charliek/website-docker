default['docker']['arch'] = 'x86_64'
default['docker']['bind_socket'] = 'unix:///var/run/docker.sock'
default['docker']['bind_uri'] = nil
default['docker']['container_cmd_timeout'] = 60
default['docker']['http_proxy'] = nil
default['docker']['image_cmd_timeout'] = 300
default['docker']['init_type'] = 'upstart'

default['docker']['container_init_type'] = node['docker']['init_type']

default['docker']['install_type'] = 'package'
default['docker']['install_dir'] = '/usr/bin'
default['docker']['version'] = nil

default['docker']['package']['distribution'] = 'docker'
default['docker']['package']['repo_url'] = 'https://get.docker.io/ubuntu'
default['docker']['package']['repo_key'] = 'https://get.docker.io/gpg'

default['docker']['package']['action'] = 'install'
