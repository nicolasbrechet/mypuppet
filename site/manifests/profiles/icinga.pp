class site::profiles::icinga {
  
  package {'icinga':
    ensure => present,
  }
  
  include icinga
  include '::mysql::server'

}