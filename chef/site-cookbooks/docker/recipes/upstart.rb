package "inotify-tools"
template '/etc/init/docker.conf' do
  source 'docker.conf.erb'
  mode '0600'
  owner 'root'
  group 'root'
  # lxc-docker package automatically starts service
  # must restart immediately to catch Upstart config changes after install
  # Need to stop&start, restart doesn't reload initd changes
  notifies :stop, 'service[docker]', :immediately
  notifies :start, 'service[docker]', :immediately
end

service 'docker' do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :reload => true
  action [:start]
end

# wait for docker to come back up
ruby_block "wait for docker to come up" do
  block do
    # This allows us to use our module helper in the ruby_block
    self.send(:extend, Helpers::Docker)
    max_wait = 20
    sleep_time = 1
    waited = 0
    while ! run('sudo docker version') do
      waited += sleep_time
      if waited >= max_wait then
        Chef::Application.fatal!("Docker did not startup within #{max_wait} seconds. Exiting.", 1)
      end
      Chef::Log.info("Docker not yet up waiting #{sleep_time} second(s) and will try again")
      sleep(sleep_time)
    end
  end
end
