class site::profiles::base {
  include ntp
  include git
  
  package {'fail2ban':
    ensure => present,
  }
  
  class { 'ssh::server':
    options => {
      'PasswordAuthentication'  => 'no',
      'PermitRootLogin'         => 'yes',
    },
  }

  package {'htop':
    ensure => installed,
  }
}
