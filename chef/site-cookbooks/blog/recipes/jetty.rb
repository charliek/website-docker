
directory node['jetty']['directory'] do
  mode "0775"
  recursive true
  action :create
end

remote_file "#{node['jetty']['directory']}/#{node['jetty']['jar']}" do 
	action :create
	checksum node['jetty']['checksum']
	source node['jetty']['url']
	mode 0644
end
