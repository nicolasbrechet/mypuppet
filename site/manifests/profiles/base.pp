class site::profiles::base {
  include ntp
  include git
  
  package {'fail2ban':
    ensure => present,
  }
}
