
# include go for butler development
include_recipe "golang::default"

# install redis with defaults since it is only used in development
package "redis-server"

# The iptables proxy that we use to allow the vagrant box to run locally requires us to
# set "net.ipv4.ip_forward" and "net.ipv6.conf.all.forwarding" to 1

execute "sysctl_refresh" do
 command "sysctl -p"
 action :nothing
end

cookbook_file "/etc/sysctl.conf" do
  source "butler_sysctl.conf"
  mode 0644
  owner "root"
  group "root"
  notifies :run, 'execute[sysctl_refresh]', :immediately
end
