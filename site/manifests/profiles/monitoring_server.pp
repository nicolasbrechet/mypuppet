class site::profiles::monitoring_server {
  # add the Ubuntu PPA for Icinga
  apt::ppa { 'ppa:formorer/icinga': }
  apt::ppa { 'ppa:formorer/icinga-web': }
  
  apt_key { 'ppa-formorer-key':
      ensure => 'present',
      id     => '36862847'
  } ->  
  package{['icinga', 'icinga-doc', 'icinga-idoutils', 'icinga-web', 'nagios-plugins']:
    ensure => installed,
  }
    
  class { '::mysql::server':
    root_password    => 'password',
  }
  
  mysql::db { 'icinga_web':
   user     => 'icinga_web',
   password => 'icinga_web',
   host     => 'localhost',
   grant    => ['SELECT', 'INSERT', 'UPDATE', 'DELETE', 'CREATE', 'DROP', 'ALTER', 'INDEX'],
  }
}