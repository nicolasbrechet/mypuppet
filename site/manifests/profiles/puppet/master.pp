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
    manage_virtualenv => true,
    reports_count     => 40,
  }
  
  class { 'apache::mod::wsgi': }
  
  class { 'puppetboard::apache::vhost':
    vhost_name => $::fqdn,
    port       => 80,
  }

  #class {'dashing':
  #  dashing_basepath     => '/usr/share/dashing',
  #} ->
  #dashing::instance {'puppetdash':
  #  targz => "https://github.com/nicolasbrechet/puppetdash/archive/1.0.0.tar.gz",
  #  dashing_port     => '3030',
  #  dashing_dir      => "/usr/share/dashing/puppetdash",
  #  strip_parent_dir => true,
  #}

}
