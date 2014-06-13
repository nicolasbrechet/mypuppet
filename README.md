 puppet apply --certname=puppet.exoremote.com --modulepath=/etc/puppet/environments/development:/etc/puppet/environments/development/modules -e 'include site::profiles::puppet::master'
