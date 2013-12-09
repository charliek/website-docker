apt_repository 'docker' do
  uri node['docker']['package']['repo_url']
  distribution node['docker']['package']['distribution']
  components ['main']
  key node['docker']['package']['repo_key']
end

# reprepro doesn't support version tagging
# See: https://github.com/dotcloud/docker/issues/979
p = 'lxc-docker'
p += "-#{node['docker']['version']}" if node['docker']['version']

package p do
  options '--force-yes'
  action node['docker']['package']['action'].intern
end
