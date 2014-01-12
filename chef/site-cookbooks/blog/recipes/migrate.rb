
if node['blog']['db']['migrate']
  execute 'blog service migrations' do
    command "/usr/bin/java -jar /opt/blog-service/blog-service-#{node['blog']['service']['version']}-shadow.jar db migrate /opt/blog-service/config.yml"
  end
end
