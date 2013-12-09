docker_service "blog-service" do
  container_name "charliek/blog-service"
  port ['5678:5678', '5679:5679']
  env "DW_DB_URL=#{node['blog']['db']['url']}"
  not_if {File.exists?("/var/run/blog-service.cid")}
end
