class site::profiles::icinga2_web {
  
  $icingaweb2_user = 'icinga2web'
  $icingaweb2_password = 'password'
  
  # MySQL DB Setup
  include '::mysql::server'
  
  mysql::db { 'icinga2web':
    user     => $icingaweb2_user,
    password => $icingaweb2_password,
    sql      => '/opt/icingaweb2/etc/schema/accounts.mysql.sql',
    require  => Vcsrepo["/opt/icingaweb2"],
  } ->
  exec {"mysql -u #{$icingaweb2_user} --password #{$icingaweb2_password} icinga2web < /opt/icingaweb2/etc/schema/preferences.mysql.sql":
  }  
  
  vcsrepo { "/opt/icingaweb2":
    ensure   => present,
    provider => git,
    source   => 'git@github.com:Icinga/icingaweb2.git',
    revision => 'c67e7c3ef0cc468b666a75d2bc4c727c3faa5c64',
  }
  
  
  
}