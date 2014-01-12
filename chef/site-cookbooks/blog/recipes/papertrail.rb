
if node['papertrail']['enabled']
  template "/etc/rsyslog.d/papertrail.conf" do
    source "papertrail.conf.erb"
    mode "0644"
    action :create
	notifies :restart, "service[rsyslog]"    
  end
end
