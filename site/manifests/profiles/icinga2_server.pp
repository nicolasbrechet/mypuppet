class site::profiles::icinga2_server {
  
  $icinga2_db_name = 'icinga2_data'
  $icinga2_user = 'icinga2'
  $icinga2_password = 'password'
  
  # MySQL DB Setup
  include '::mysql::server'
  
  mysql::db { $icinga2_db_name:
    user     => $icinga2_user,
    password => $icinga2_password,
  }
  
  #Install Icinga 2:
  class { 'icinga2::server': 
    server_db_type  => 'mysql',
    db_host         => 'localhost',
    db_port         => '3306',
    db_name         => $icinga2_db_name,
    db_user         => $icinga2_user,
    db_password     => $icinga2_password,
    server_install_nagios_plugins => false,
    install_mail_utils_package => true,
  } ->
  icinga2::object::idomysqlconnection { 'mysql_connection':
     target_dir       => '/etc/icinga2/features-enabled',
     target_file_name => 'ido-mysql.conf',
     host             => '127.0.0.1',
     port             => 3306,
     user             => $icinga2_user,
     password         => $icinga2_password,
     database         => $icinga2_db_name,
     categories       => ['DbCatConfig', 'DbCatState', 'DbCatAcknowledgement', 'DbCatComment', 'DbCatDowntime', 'DbCatEventHandler' ],
  } ->  
  class { 'icinga2::nrpe':
    nrpe_allowed_hosts                => ['92.222.172.34', '127.0.0.1']
  }
  
  
  # First MySQL DB then Icinga
  Mysql::Db <||> -> Class['icinga2::server']
}