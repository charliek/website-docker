docker_service "grails-blog" do
  container_name "charliek/grails-blog"
  port '8080:8080'
  setup_partial "host_setup.erb"
  env [
  	"GITHUB_CLIENT_ID=#{node['blog']['github']['client_id']}",
  	"GITHUB_SECRET=#{node['blog']['github']['secret']}",
  	"CLIENT_PREFIX=#{node['blog']['client']['prefix']}",
  	"ETCD_URL=#{node['blog']['etcd']['url']}",
  	"HOST_IP=$HOST_IP"
  ]
  not_if {File.exists?("/var/run/grails-blog.cid")}
end
