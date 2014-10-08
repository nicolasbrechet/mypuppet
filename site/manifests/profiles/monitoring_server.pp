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
  
  
  # DB setup
  # mysql -u root -p
  #mysql> CREATE DATABASE icinga_web;
  #       GRANT USAGE ON *.* TO 'icinga_web'@'localhost' IDENTIFIED BY 'icinga_web' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0;
  #       GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER, INDEX ON icinga_web.* TO 'icinga_web'@'localhost';
  #       quit
  
  
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