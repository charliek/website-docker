docker_service "blog-service" do
  container_name "charliek/blog-service"
  port ['5678:5678', '5679:5679']
  setup_partial "host_setup.erb"
  env [
  	"DW_DB_URL=#{node['blog']['db']['url']}",
  	"ETCD_URL=#{node['blog']['etcd']['url']}",
  	"HOST_IP=$HOST_IP"
  ]
  not_if {File.exists?("/var/run/blog-service.cid")}
end
