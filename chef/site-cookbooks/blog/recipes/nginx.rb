include_recipe "blog::_setup"
include_recipe "apt"

apt_repository "nginx-devel" do
  uri "http://ppa.launchpad.net/chris-lea/nginx-devel/ubuntu"
  distribution node['lsb']['codename']
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "C7917B12"
  action :add
end

package "nginx"
package "nginx-common"
package "nginx-full"

service 'nginx' do
  supports :status => true, :restart => true, :reload => true
  action   :start
end

sites_available = "/etc/nginx/sites-available"
sites_enabled = "/etc/nginx/sites-enabled"

file "#{sites_enabled}/default" do
  action :delete
end

file "#{sites_available}/default" do
  action :delete
  notifies :reload, "service[nginx]"
end

key_dir = node['nginx']['key']['directory']

directory key_dir do
  mode "0775"
  recursive true
  action :create
end

template "#{key_dir}/server.key" do
	source      'key.erb'
	owner       'root'
	group       'root'
	mode        '0440'
	variables(
		:key => node['nginx']['key']['server']
	)
    notifies :reload, "service[nginx]"
end

template "#{key_dir}/ssl-bundle.crt" do
	source      'key.erb'
	owner       'root'
	group       'root'
	mode        '0440'
	variables(
		:key => node['nginx']['key']['ssl-bundle']
	)
	notifies :reload, "service[nginx]"
end

template "#{sites_enabled}/blog" do
  source "nginx-blog.erb"
  mode "0644"
  action :create
  notifies :reload, "service[nginx]"
end

template "#{sites_enabled}/https-only" do
  source "nginx-https-only.erb"
  mode "0644"
  action :create
  notifies :reload, "service[nginx]"
end


