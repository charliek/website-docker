include_recipe "apt"

# move encrypted values in the environment into attribute space
if node['blog']['encrypted']
	current_node = node
	db_values = Chef::EncryptedDataBagItem.load("site", node['blog']['environment']).to_hash
	Helpers::Blog.applyHashToAttributes(db_values, node.default)
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
package "htop"
