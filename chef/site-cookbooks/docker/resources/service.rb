actions :create

default_action :create

attribute :container_name, :kind_of => [String], :name_attribute => true
attribute :service_name, :kind_of => [String], :name_attribute => true
attribute :tag, :kind_of => [String], :default => 'latest', :name_attribute => true
attribute :env, :kind_of => [String, Array], :name_attribute => true
attribute :port, :kind_of => [String, Array], :name_attribute => true
attribute :cmd_timeout, :kind_of => [Integer], :default => node['docker']['container_cmd_timeout'], :name_attribute => true
