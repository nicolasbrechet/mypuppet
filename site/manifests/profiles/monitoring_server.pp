class site::profiles::monitoring_server {
  # add the Ubuntu PPA for Icinga
  apt::ppa { 'ppa:formorer/icinga': }
  apt::ppa { 'ppa:formorer/icinga-web': }
  
  apt_key { 'ppa-formorer-key':
      ensure => 'present',
      id     => '36862847'
  } ->  
  package{['icinga', 'icinga-doc', 'icinga-idoutils', 'icinga-web']:
    ensure => installed,
  }
}