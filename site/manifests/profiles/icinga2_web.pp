class site::profiles::icinga2_web {
  
  $icingaweb2_db_name = 'icinga2web'
  $icingaweb2_user = 'icinga2web'
  $icingaweb2_password = 'password'
  
  # MySQL DB Setup
  include '::mysql::server'
  
  vcsrepo { "/opt/icingaweb2":
    ensure   => present,
    provider => git,
    source   => 'git@github.com:Icinga/icingaweb2.git',
    revision => 'c67e7c3ef0cc468b666a75d2bc4c727c3faa5c64',
  } 
  
  concat { "/opt/sqlimport.sql":
    owner   => 'root',
    group   => 'root',
    mode    => '0644'
  } 
  
  concat::fragment { 'accounts':
    target  => "/opt/sqlimport.sql",
    source  => '/opt/icingaweb2/etc/schema/accounts.mysql.sql',
    order   => '01'
  } 
  
  concat::fragment { 'preferences':
    target  => "/opt/sqlimport.sql",
    source  => '/opt/icingaweb2/etc/schema/preferences.mysql.sql',
    order   => '02'
  } 
  
  mysql::db { $icingaweb2_db_name:
    user     => $icingaweb2_user,
    password => $icingaweb2_password,
    sql      => '/opt/sqlimport.sql',
  }
  
  Vcsrepo["/opt/icingaweb2"] <| |> 
    -> Concat["/opt/sqlimport.sql"] <| |> 
    -> Mysql::Db[$icingaweb2_db_name] <| |> 
  
}