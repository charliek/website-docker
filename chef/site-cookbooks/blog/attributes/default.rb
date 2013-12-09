default['blog']['create_users'] = true
default['blog']['environment'] = 'vagrant'
default['blog']['encrypted'] = true

# defaults that general work for a vagrant develop environment
default['blog']['db']['url'] = "jdbc:mysql://192.168.70.1:3306/blog"
default['blog']['client']['prefix'] = "http://172.17.42.1:5678"

# github tokens set in databags but are required for admin to work
default['blog']['github']['secret'] = ""
default['blog']['github']['client_id'] = ""

