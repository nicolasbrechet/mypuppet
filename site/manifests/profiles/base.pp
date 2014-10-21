class site::profiles::base {
  include ntp
  include apt
  include git

  include fail2ban
  
  package { 'htop':
    ensure => installed,
  }
  
  class { 'ssh::server':
    options => {
      'PasswordAuthentication'  => 'no',
      'PermitRootLogin'         => 'yes',
    },
  }
}
