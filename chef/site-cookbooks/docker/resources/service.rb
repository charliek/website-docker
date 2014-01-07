actions :create

default_action :create

attribute :container_name, :kind_of => [String]
attribute :service_name, :kind_of => [String], :name_attribute => true
attribute :tag, :kind_of => [String], :default => 'latest'
attribute :env, :kind_of => [String, Array]
attribute :port, :kind_of => [String, Array]
attribute :cmd_timeout, :kind_of => [Integer], :default => node['docker']['container_cmd_timeout']
attribute :setup_partial, :kind_of => [String, NilClass], :default => nil
