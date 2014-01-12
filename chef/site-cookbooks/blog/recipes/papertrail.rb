
service 'rsyslog' do
  supports :status => true, :restart => true, :reload => false
  action   :start
end

# Default syslog file with tcp and udp listeners turned on
template "/etc/rsyslog.conf" do
  source "rsyslog.conf.erb"
  mode "0644"
  action :create
  notifies :restart, "service[rsyslog]"    
end

if node['papertrail']['enabled']
  template "/etc/rsyslog.d/papertrail.conf" do
    source "papertrail.conf.erb"
    mode "0644"
    action :create
	notifies :restart, "service[rsyslog]"    
  end
end
