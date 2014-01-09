default['blog']['create_users'] = true
default['blog']['environment'] = 'vagrant'
default['blog']['encrypted'] = true

# defaults that general work for a vagrant develop environment
default['blog']['db']['url'] = "jdbc:mysql://192.168.70.1:3306/blog"
default['blog']['client']['prefix'] = "http://172.17.42.1:5678"
default['blog']['etcd']['url'] = "http://192.168.70.1:4001"

# github tokens set in environment databags but are required for admin to work
default['blog']['github']['secret'] = ""
default['blog']['github']['client_id'] = ""


default['blog']['service']['version'] = "0.0.2-SNAPSHOT"
default['blog']['grails']['version'] = "0.1-SNAPSHOT"


default['jetty']['url'] = "http://repo1.maven.org/maven2/org/eclipse/jetty/jetty-runner/9.1.0.v20131115/jetty-runner-9.1.0.v20131115.jar"
default['jetty']['checksum'] = "f3a2e247ae4b9cdbdad792fa5aebd843371ae9140f8cdcc1a3a3052fda5db844"
default['jetty']['directory'] = '/opt/jetty-runner'
default['jetty']['jar'] = 'jetty-runner-9.1.0.jar'
default['jetty']['path'] = "#{default['jetty']['directory']}/#{default['jetty']['jar']}"
