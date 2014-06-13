class site::profiles::puppet::master {

  anchor { '::profiles::puppet::master': }

  Class {
    require => Anchor['::profiles::puppet::master']
  }

  class { '::puppet::server':
    environmentpath    => '$confdir/environments/',
    servertype         => 'passenger',
    reports            => 'puppetdb',
    servername         => $::fqdn,
    config_version_cmd => false,
    reporturl          => '',
    ca                 => true,
  } ->
  class { 'puppetdb': } ->
  class { 'puppetdb::master::config': }

}