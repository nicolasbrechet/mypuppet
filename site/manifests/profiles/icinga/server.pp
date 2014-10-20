class site::profiles::icinga::server {
  
  # MySQL DB Setup
  class { 'mysql::server':
  } ->
  mysql::db { 'icinga2_data':
    user     => 'icinga2',
    password => 'password',
  }
  
  #Install Icinga 2:
  class { 'icinga2::server': 
    server_db_type  => 'mysql',
    db_host         => 'localhost',
    db_port         => '3306',
    db_name         => 'icinga2_data',
    db_user         => 'icinga2',
    db_password     => 'password',
    server_install_nagios_plugins => false,
    install_mail_utils_package => true,
  } ->
  icinga2::object::idomysqlconnection { 'mysql_connection':
     target_dir       => '/etc/icinga2/features-enabled',
     target_file_name => 'ido-mysql.conf',
     host             => '127.0.0.1',
     port             => 3306,
     user             => 'icinga2',
     password         => 'password',
     database         => 'icinga2_data',
     categories       => ['DbCatConfig', 'DbCatState', 'DbCatAcknowledgement', 'DbCatComment', 'DbCatDowntime', 'DbCatEventHandler' ],
  } ->  
  class { 'icinga2::nrpe':
    nrpe_allowed_hosts                => ['92.222.172.34', '127.0.0.1'],
    allow_command_argument_processing => 0, # set to 1 to allow /!\ security risk!
  }
  
  
  # First MySQL DB then Icinga
  Mysql::Db <||> -> Class['icinga2::server']
}