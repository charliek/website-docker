include_recipe "apt"

# move encrypted values in the environment into attribute space
if node['blog']['encrypted']
	db_values = Chef::EncryptedDataBagItem.load("site", node['blog']['environment'])
	node.set['blog']['etcd']['url'] = db_values['blog']['etcd']['url']
	node.set['blog']['db']['url'] = db_values['blog']['db']['url']
	node.set['blog']['github']['secret'] = db_values['blog']['github']['secret']
	node.set['blog']['github']['client_id']	= db_values['blog']['github']['client_id']
	node.set['blog']['client']['prefix'] = db_values['blog']['client']['prefix'] 
end

# setup users so we can login if something after fails.
if node['blog']['create_users']
  include_recipe "blog::users"
end

cookbook_file "iplookup" do
  path "/usr/bin/iplookup"
  mode '0755'
  owner 'root'
  group 'root'
  action :create_if_missing
end

package "openjdk-7-jre-headless"

include_recipe "blog::blog-service"
include_recipe "blog::grails-blog"

