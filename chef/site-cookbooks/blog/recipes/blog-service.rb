directory '/opt/blog-service' do
  mode "0775"
  recursive true
  action :create
end

remote_file "/opt/blog-service/blog-service-#{node['blog']['service']['version']}-shadow.jar" do 
  action :create
  source "https://s3-us-west-2.amazonaws.com/charliek-apps/blog-service/blog-service-#{node['blog']['service']['version']}-shadow.jar"
  mode 0644
end

remote_file "/opt/blog-service/config.yml" do 
  action :create
  source "https://s3-us-west-2.amazonaws.com/charliek-apps/blog-service/config.yml"
  mode 0644
end

template "/etc/init/blog-service.conf" do
  source "blog-service.conf.erb"
  mode "0644"
  action :create
end

service "blog-service" do
  provider Chef::Provider::Service::Upstart
  supports :restart => true, :start => true, :stop => true, :reload => false
  action [ :enable, :start]
end
