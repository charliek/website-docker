include_recipe "blog::jetty"

directory '/opt/grails-blog' do
  mode "0775"
  recursive true
  action :create
end

remote_file "/opt/grails-blog/blog-#{node['blog']['grails']['version']}.war" do 
  action :create
  source "https://s3-us-west-2.amazonaws.com/charliek-apps/grails-blog/blog-#{node['blog']['grails']['version']}.war"
  mode 0644
end

template "/etc/init/grails-blog.conf" do
  source "grails-blog.conf.erb"
  mode "0644"
  action :create
  notifies :restart, "service[grails-blog]"
end

service "grails-blog" do
  provider Chef::Provider::Service::Upstart
  supports :restart => true, :start => true, :stop => true, :reload => false
  action [ :enable, :start]
end
