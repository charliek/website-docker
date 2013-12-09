include_recipe "user"

user_db = Chef::EncryptedDataBagItem.load("site", "users")
users = user_db["users"]

users.each do |u|
	username = u['username']
	Chef::Log.info("Setting up user '#{username}'")

	user_account username do
		comment  u['full_name']
		ssh_keys u['ssh_keys']
	end

	u['groups'].each do |group_name|
		group group_name do
			members username
			append true
      	end
	end

	template "/etc/sudoers.d/#{username}" do
    	source      'sudoersd.erb'
    	owner       'root'
    	group       'root'
    	mode        '0400'
    	variables(
    		:username => username
    	)
  end
end

