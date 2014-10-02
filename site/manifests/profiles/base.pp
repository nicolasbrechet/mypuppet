class site::profiles::base {
  include ntp
  include apt
  include git
  
  package { ['fail2ban', 'htop']:
    ensure => latest,
  }
  
  class { 'ssh::server':
    options => {
      'PasswordAuthentication'  => 'no',
      'PermitRootLogin'         => 'yes',
    },
  }
}
