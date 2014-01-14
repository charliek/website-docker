
# TODO need to override db creds and path similar to what is done in upstart
execute 'blog service migrations' do
  command "/usr/bin/java -jar /opt/blog-service/blog-service-#{node['blog']['service']['version']}-shadow.jar db migrate /opt/blog-service/prod_config.yml"
  only_if { node['blog']['db']['migrate'] }
end
