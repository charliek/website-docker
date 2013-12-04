#!/bin/bash

set -x

CHEFDIR="/opt/chef-solo" 
CHEFSOLO="/usr/local/bin/chef-solo"
NODEDIR="solo-nodes"
NODE_JSON="$1"

if [ -z $NODE_JSON ]; then 
  echo "You must pass the absolute path the solo node you want to execute as first argument"
  exit 1; 
fi

if [ ! -f "$NODE_JSON" ]; then
  echo "Couldn't locate '$NODE_JSON'"
  exit 1
fi;

if [ ! -f "/usr/bin/ruby1.9.1" ] ; then
  # update the only the first time through
  apt-get update
  
  # Install proper ruby version
  apt-get install -y ruby1.9.1 ruby1.9.1-dev make
  update-alternatives --set ruby /usr/bin/ruby1.9.1
  update-alternatives --set gem /usr/bin/gem1.9.1
fi;


if [ ! -x ${CHEFSOLO} ]; then
  # Install Chef
  gem source --add https://rubygems.org/
  gem install --no-rdoc --no-ri chef --version 11.8.2

  # Install git (needed by librarian-chef)
  sudo apt-get install git -y

  # Setup librarian which is used to download cookbooks
  gem install --no-rdoc --no-ri librarian-chef

  # Setup Chef Solo
  mkdir -p $CHEFDIR/cache

cat > $CHEFDIR/solo.rb << EOF
root = '$CHEFDIR/website/chef'
file_cache_path '$CHEFDIR/cache' 
cookbook_path [ root + '/cookbooks', root + '/site-cookbooks']
role_path root + '/roles'
data_bag_path root + '/data_bags'
EOF

  chown root:root $CHEFDIR/solo.rb
  chmod 644 $CHEFDIR/solo.rb
fi;

# Pull down cookbooks
pushd /opt/chef-solo/website/chef/
sudo librarian-chef install --path=cookbooks
popd

# Execute chef
if [ -x ${CHEFSOLO} ]; then
   ${CHEFSOLO} -c ${CHEFDIR}/solo.rb -j "$NODE_JSON"
   chefrtn=$?
   echo "Chef Solo run completed with status code '${chefrtn}'"
   exit ${chefrtn}
else
   echo "Unable to find an executable chef-solo at: '${CHEFSOLO}'"
   exit 2    
fi
