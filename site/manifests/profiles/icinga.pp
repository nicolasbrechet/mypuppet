class site::profiles::icinga {
  
  class { '::mysql::server': 
  } ->
  class { 'icinga':
  }
  
  
}