class site::profiles::php_fpm {
  include php
  include php::fpm
  include php::params
  
  create_resources('php::fpm::pool',  hiera_hash('php_fpm_pool', {}))
  create_resources('php::fpm::config',  hiera_hash('php_fpm_config', {}))
  
  Php::Extension <| |> ~> Service['php5-fpm']

  exec { "restart-php5-fpm":
    command  => "service php5-fpm restart",
    schedule => hourly
  }
}