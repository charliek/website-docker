include_recipe "postgresql::client"
include_recipe "database::postgresql"

# This is only expected to be used for development at this time.

postgresql_connection_info = {
  :host     => '127.0.0.1',
  :port     => node['postgresql']['config']['port'],
  :username => 'postgres',
  :password => node['postgresql']['password']['postgres']
}

postgresql_database 'blog' do
  connection postgresql_connection_info
  action :create
end

postgresql_database_user 'blog' do
  connection    postgresql_connection_info
  password 'blog'
  database_name 'blog'
  privileges    [:all]
  action        :create
end
