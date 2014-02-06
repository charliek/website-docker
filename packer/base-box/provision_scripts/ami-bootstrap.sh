set -x

CHEFDIR="/opt/chef-solo"
CHEFSOLO="/usr/bin/chef-solo"
CHEF_KEY="/opt/provision/encrypted_data_bag_secret"
CHEFDIR="/opt/chef-solo"

if [ ! -d $CHEFDIR/website ]; then
    cd $CHEFDIR
    sudo git clone https://github.com/charliek/website-docker.git website
fi

/opt/provision/node_env.py $SOLO_NODE $CHEF_ENV

if [ ! -f $CHEFDIR/solo.rb ]; then
    cat > $CHEFDIR/solo.rb <<EOF
root = '$CHEFDIR/website/chef'
file_cache_path '$CHEFDIR/cache'
cookbook_path [ root + '/cookbooks']
role_path root + '/roles'
data_bag_path root + '/data_bags'
encrypted_data_bag_secret "/opt/provision/encrypted_data_bag_secret"
log_level :info
log_location '/var/log/chef-solo.log'
EOF
  sudo chown root:root $CHEFDIR/solo.rb
  sudo chmod 644 $CHEFDIR/solo.rb
fi

if [ ! -f "$SOLO_NODE" ]; then
  echo "Couldn't locate '$SOLO_NODE'"
  exit 2;
fi;

if [ ! -f $CHEF_KEY ] ; then
   echo "Unable to find the key used for encrypted databags at: '${CHEF_KEY}'"
   exit 3;
fi

pushd $CHEFDIR/website/chef/
sudo /opt/chef/embedded/bin/librarian-chef install --path=cookbooks
popd

# Execute chef
if [ -x ${CHEFSOLO} ]; then
   ${CHEFSOLO} -c ${CHEFDIR}/solo.rb -j "$SOLO_NODE"
   chefrtn=$?
   echo "Chef Solo run completed with status code '${chefrtn}'"
   exit ${chefrtn}
else
   echo "Unable to find an executable chef-solo at: '${CHEFSOLO}'"
   exit 4;
fi
