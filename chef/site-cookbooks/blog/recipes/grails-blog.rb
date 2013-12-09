docker_service "grails-blog" do
  container_name "charliek/grails-blog"
  port '8080:8080'
  env ["GITHUB_CLIENT_ID=#{node['blog']['github']['client_id']}", "GITHUB_SECRET=#{node['blog']['github']['secret']}", "CLIENT_PREFIX=#{node['blog']['client']['prefix']}"]
  not_if {File.exists?("/var/run/grails-blog.cid")}
end
