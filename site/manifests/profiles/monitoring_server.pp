class site::profiles::monitoring_server {
  
  class {'::mysql::server':
  } ->
  mysql::db { 'icinga DB':
    dbname    => hiera('icinga::params::ido_db_name'),
    user      => hiera('icinga::params::ido_db_user'),
    password  => hiera('icinga::params::ido_db_pass'),
    host      => hiera('icinga::params::ido_db_host'),
  } ->
  mysql::db { 'icinga web DB':
    dbname    => hiera('icinga::params::web_db_name'),
    user      => hiera('icinga::params::web_db_user'),
    password  => hiera('icinga::params::web_db_pass'),
    host      => hiera('icinga::params::web_db_host')
  }
  
  include icinga
  include pnp4nagios
  include nrpe
  include nrpe::monitoring
  
  group {'nrpe':
    ensure => present,
  }
  
  user {'nrpe':
    ensure => present,
  }
  
  Group['nrpe'] 
  -> User['nrpe'] 
  -> Class['nrpe'] 
  -> Class['nrpre::monitoring']
  
}