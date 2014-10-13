class site::profiles::puppet::master {

  anchor { '::profiles::puppet::master': }

  Class {
    require => Anchor['::profiles::puppet::master']
  }
  
  class { '::puppet::server':
    environmentpath    => '$confdir/environments',
    servertype         => 'passenger',
    reports            => 'puppetdb',
    servername         => $::fqdn,
    config_version_cmd => false,
    reporturl          => '',
    ca                 => true,
    autosign           => hiera('puppet::server::autosign'),
  } ->
  class { 'puppetdb': } ->
  class { 'puppetdb::master::config': }
  
  class { 'puppetboard': 
    manage_git        => true,
    manage_virtualenv => true,
    reports_count     => 40,
  }
  
  class { 'apache::mod::wsgi': }
  
  class { 'puppetboard::apache::vhost':
    vhost_name => $::fqdn,
    port       => 80,
  }

}
