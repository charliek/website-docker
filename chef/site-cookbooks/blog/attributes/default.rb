default['blog']['create_users'] = true
default['blog']['environment'] = 'vagrant'
default['blog']['encrypted'] = true

# defaults that general work for kitchen tests
default['blog']['db']['name'] = 'blog'
default['blog']['db']['host'] = '127.0.0.1'
default['blog']['db']['url'] = "jdbc:postgresql://127.0.0.1:5432/blog"
default['blog']['db']['user'] = "blog"
default['blog']['db']['password'] = "blog"
default['blog']['db']['migrate'] = true

default['blog']['client']['prefix'] = "http://10.0.2.15:5678"
default['blog']['etcd']['url'] = "http://10.0.2.15:4001"

# github tokens must be set in encrypted databag
default['blog']['github']['secret'] = ""
default['blog']['github']['client_id'] = ""

default['blog']['service']['version'] = "0.0.2-SNAPSHOT"
default['blog']['grails']['version'] = "0.1-SNAPSHOT"

default['jetty']['url'] = "http://repo1.maven.org/maven2/org/eclipse/jetty/jetty-runner/9.1.0.v20131115/jetty-runner-9.1.0.v20131115.jar"
default['jetty']['checksum'] = "f3a2e247ae4b9cdbdad792fa5aebd843371ae9140f8cdcc1a3a3052fda5db844"
default['jetty']['directory'] = '/opt/jetty-runner'
default['jetty']['jar'] = 'jetty-runner-9.1.0.jar'
default['jetty']['path'] = "#{default['jetty']['directory']}/#{default['jetty']['jar']}"

default['papertrail']['enabled'] = false
default['papertrail']['events'] = '*.*'
default['papertrail']['host'] = ''

default['nginx']['ssl'] = true
default['nginx']['key']['directory'] = "/etc/nginx/keys"
default['nginx']['host'] = "blog-vagrant.charlieknudsen.com"

# nginx certs must be set in encrypted databag
default['nginx']['key']['server'] = ""
default['nginx']['key']['ssl-bundle'] = ""
