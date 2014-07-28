class site::profiles::puppet::master {

  anchor { '::site::profiles::puppet::master': }

  Class {
    require => Anchor['::site::profiles::puppet::master']
  }
  
  class { 'ssh::server':
    options => {
      'PasswordAuthentication'  => 'no',
      'PermitRootLogin'         => 'yes',
    },
  }
  
  class { '::puppet::server':
    modulepath         => ['$confdir/environments/$environment/modules', '$confdir/environments/$environment/'],
    manifest           => '$confdir/environments/$environment/site/manifests/site.pp',
    servertype         => 'passenger',
    reports            => 'puppetdb',
    servername         => $::fqdn,
    config_version_cmd => false,
    backup_server      => false,
    reporturl          => '',
    ca                 => true,
    autosign           => hiera('puppet::server::autosign'),
  } ->
  class { 'puppetdb': } ->
  class { 'puppetdb::master::config': } ->
  class { 'puppetboard': 
    manage_virtualenv => true,
  }
  
  class { 'apache::mod::wsgi': }
  
  class { 'puppetboard::apache::vhost':
    vhost_name => $::fqdn,
    port       => 80,
  }

}
