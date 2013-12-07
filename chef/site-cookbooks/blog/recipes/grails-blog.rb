docker_image "charliek/grails-blog" do
	cmd_timeout 600
end

docker_container "grails_blog" do
  image "charliek/grails-blog"
  detach true
  port '8080:8080'
  env ["SETTINGS_FLAVOR=local", "GITHUB_CLIENT_ID=xxxxx", "GITHUB_SECRET=xxxx", "CLIENT_PREFIX=http://172.17.42.1:5678"]
  not_if {File.exists?("/var/run/grails-blog.cid")}
end
