
# TODO need to override db creds and path similar to what is done in upstart
execute 'blog service migrations' do
  command "/usr/bin/java -Ddw.database.url=#{node['blog']['db']['url']} -Ddw.database.password=#{node['blog']['db']['password']} -jar /opt/blog-service/blog-service-#{node['blog']['service']['version']}-shadow.jar db migrate /opt/blog-service/prod_config.yml"
  only_if { node['blog']['db']['migrate'] }
end
