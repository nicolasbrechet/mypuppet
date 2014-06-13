class site::profiles::puppet::master {

  anchor { '::site::profiles::puppet::master': }

  Class {
    require => Anchor['::site::profiles::puppet::master']
  }

  class { '::puppet::server':
    environmentpath    => '$confdir/environments/',
    servertype         => 'passenger',
    reports            => 'puppetdb',
    servername         => $::fqdn,
    config_version_cmd => false,
    backup_server      => false,
    reporturl          => '',
    ca                 => true,
  } ->
  class { 'puppetdb': } ->
  class { 'puppetdb::master::config': }

}