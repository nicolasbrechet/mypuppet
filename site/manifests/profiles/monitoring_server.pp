class site::profiles::monitoring_server {
  # add the Ubuntu PPA for Icinga
  apt::ppa { 'ppa:formorer/icinga': }
  apt::ppa { 'ppa:formorer/icinga-web': }
  
  apt_key { 'ppa-formorer-key':
      ensure => 'present',
      id     => '36862847'
  } -> 
  icinga::server { 'monitoring server':
    icinga_configure_webserver  => true,
    icinga_webserver            => 'apache2', #default
    icinga_webserver_port       => '80', 
    icinga_vhostname            => 'monitoring.nicolasbrechet.com',
    
    # => Generates /etc/icinga/monitoring.nicolasbrechet.com-apache2.conf.example 
  } ->
  class { 'apache':
    default_vhost => false,
  } ->
  file { '/etc/icinga/monitoring.nicolasbrechet.com-apache2.conf.example':
     ensure => 'link',
     target => '/etc/apache2/sites-enabled/25-monitoring.nicolasbrechet.com-apache2.conf',
  }

  
}