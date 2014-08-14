class site::profiles::puppet::master {

  anchor { '::site::profiles::puppet::master': }

  Class {
    require => Anchor['::site::profiles::puppet::master']
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
    reports_count     => 40,
  }
  
  class { 'apache::mod::wsgi': }
  
  class { 'puppetboard::apache::vhost':
    vhost_name => $::fqdn,
    port       => 80,
  }
  
  postgresql::server::pg_hba_rule { 'Trust all localhost connections':
    type        => 'host',
    address     => '127.0.0.1/32',
    database    => 'all',
    user        => 'postgres',
    auth_method => 'trust',
    /* Important, this must be the 1st rule */
    order       => '000'
  }

}
