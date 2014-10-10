class site::profiles::icinga2_web {
  
  # MySQL DB Setup
  include '::mysql::server'
  
  mysql::db { 'icinga2web':
    user     => 'icinga2web',
    password => 'password',
    sql      => ['/opt/icingaweb2/etc/schema/accounts.mysql.sql','/opt/icingaweb2/etc/schema/preferences.mysql.sql'],
    require  => Vcsrepo["/var/icingaweb2"],
  }
  
  vcsrepo { "/var/icingaweb2":
    ensure   => present,
    provider => git,
    source   => 'git@github.com:Icinga/icingaweb2.git',
    revision => 'c67e7c3ef0cc468b666a75d2bc4c727c3faa5c64',
  }
  
  
  
}