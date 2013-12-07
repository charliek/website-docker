docker_image "charliek/blog-service" do
	cmd_timeout 600
end

docker_container "blog-service" do
  image "charliek/blog-service"
  detach true
  port ['5678:5678', '5679:5679']  
  env "DW_DB_URL=jdbc:mysql://192.168.70.1:3306/blog"
  not_if {File.exists?("/var/run/blog-service.cid")}
end
