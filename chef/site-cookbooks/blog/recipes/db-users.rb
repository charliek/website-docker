include_recipe "postgresql::client"
include_recipe "database::postgresql"

postgresql_connection_info = {
  :host     => node['blog']['db']['host'],
  :port     => node['postgresql']['config']['port'],
  :username => node['postgresql']['root']['user'],
  :password => node['postgresql']['password']['postgres']
}

postgresql_database node['blog']['db']['name'] do
  connection postgresql_connection_info
  action :create
end

postgresql_database_user node['blog']['db']['user'] do
  connection    postgresql_connection_info
  password node['blog']['db']['password']
  database_name 'blog'
  privileges    [:all]
  action        :create
  retries 10     # retry the migrations 20 times
  retry_delay 30 # wait 1 minute between the trys
end
