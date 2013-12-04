#!/bin/bash

set -x

CHEFDIR="/opt/chef-solo" 
CHEFSOLO="/usr/bin/chef-solo"
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


if [ ! -x ${CHEFSOLO} ]; then
  # update the only the first time through
  apt-get -y update

  # Install Chef
  apt-get -y install curl build-essential libxml2-dev libxslt-dev git
  curl -L https://www.opscode.com/chef/install.sh | bash
  echo "gem: --no-ri --no-rdoc" > ~/.gemrc
  
  /opt/chef/embedded/bin/gem source --add https://rubygems.org/

  # Install git (needed by librarian-chef)
  sudo apt-get install git -y

  # Setup librarian which is used to download cookbooks
  /opt/chef/embedded/bin/gem install --no-rdoc --no-ri librarian-chef

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
sudo /opt/chef/embedded/bin/librarian-chef install --path=cookbooks
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
