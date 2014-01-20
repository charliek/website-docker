directory '/opt/blog-service' do
  mode "0775"
  recursive true
  action :create
end

# TODO only run this if the md5 file shows a download is needed
remote_file "/opt/blog-service/blog-service-#{node['blog']['service']['version']}-shadow.jar" do 
  action :create
  source "https://s3-us-west-2.amazonaws.com/charliek-apps/blog-service/blog-service-#{node['blog']['service']['version']}-shadow.jar"
  mode 0644
  # notifies :run, "execute[blog-service-config]", :immediately
end

# TODO figure out how to only run this if a new file has been downloaded
execute "blog-service-config" do
  command "unzip -u -o /opt/blog-service/blog-service-#{node['blog']['service']['version']}-shadow.jar prod_config.yml -d /opt/blog-service/"
  notifies :restart, "service[blog-service]"
  # action :nothing
end

template "/etc/init/blog-service.conf" do
  source "blog-service.conf.erb"
  mode "0644"
  action :create
  notifies :restart, "service[blog-service]"
end

service "blog-service" do
  provider Chef::Provider::Service::Upstart
  supports :restart => true, :start => true, :stop => true, :reload => false
  action [ :enable, :start]
end
