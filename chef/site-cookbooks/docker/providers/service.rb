include Helpers::Docker

action :create do
  
  execute "docker pull #{container_name}"

  run_args = cli_args(
    'e' => [*new_resource.env],
    'p' => [*new_resource.port]
  )

  template "/etc/init/#{service_name}.conf" do
    source 'docker-container.conf.erb'
    mode '0600'
    owner 'root'
    group 'root'
    cookbook 'docker'
    variables(
      :cmd_timeout => new_resource.cmd_timeout,
      :service_name => service_name,
      :container_name => container_name,
      :service_params => run_args
    )
  end

  service service_name do
    provider Chef::Provider::Service::Upstart
    supports :status => true, :restart => true, :reload => true
    action [:start, :enable]
  end
  new_resource.updated_by_last_action(true)
end

def container_name
  "#{new_resource.container_name}:#{new_resource.tag}"
end

def service_name
  new_resource.service_name || new_resource.container_name.split('/')[-1]
end
