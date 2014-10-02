class site::profiles::icinga {
  
  package {['icinga', 'icinga-idoutils']:
    ensure => present,
  } 
  
  class {'::mysql::server':
  } ->
  mysql_database { 'icinga':
    ensure  => 'present',
    charset => 'utf8',
    collate => 'utf8_swedish_ci',
  } ->
  mysql_database { 'icinga_web':
    ensure  => 'present',
    charset => 'utf8',
    collate => 'utf8_swedish_ci',
  } ->  
  mysql_user { 'icinga@localhost':
    ensure                   => 'present',
    max_connections_per_hour => '0',
    max_queries_per_hour     => '0',
    max_updates_per_hour     => '0',
    max_user_connections     => '0',
  } ->  
  mysql_grant { 'icinga@localhost/*.*':
    ensure     => 'present',
    options    => ['GRANT'],
    privileges => ['ALL'],
    table      => '*.*',
    user       => 'icinga@localhost',
  }
  
  include icinga

}