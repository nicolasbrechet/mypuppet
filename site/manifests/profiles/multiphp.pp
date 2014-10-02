class site::profiles::multiphp {
  class { 'apache': 
    default_vhost => false,
    
  }
  
  apache::mod { 'proxy': }
  apache::mod { 'proxy_fcgi': }
  
  apache::vhost { 'truc1.com':
    port            => '80',
    docroot         => '/var/www/html/truc1',
    custom_fragment => 'ProxyPassMatch ^/(.*\.php(/.*)?)$ fcgi://127.0.0.1:9001/var/www/html/truc1/$1'
  }
  
  apache::vhost { 'truc2.com':
    port            => '80',
    docroot         => '/var/www/html/truc2',
    custom_fragment => 'ProxyPassMatch ^/(.*\.php(/.*)?)$ fcgi://127.0.0.1:9002/var/www/html/truc2/$1'
  }
  
  apache::vhost { 'truc3.com':
    port            => '80',
    docroot         => '/var/www/html/truc3',
    custom_fragment => 'ProxyPassMatch ^/(.*\.php(/.*)?)$ fcgi://127.0.0.1:9003/var/www/html/truc3/$1'
  }
  
  include php
  include php::fpm
  include php::params
  
  php::fpm::pool { 'truc1':
    listen => '127.0.0.1:9001',
  }
  
  php::fpm::pool { 'truc2':
    listen => '127.0.0.1:9002',
  }
  
  php::fpm::pool { 'truc3':
    listen => '127.0.0.1:9003',
  }
  
  #create_resources('php::fpm::pool',  hiera_hash('php_fpm_pool', {}))
  create_resources('php::fpm::config',  hiera_hash('php_fpm_config', {}))
  
  # Install extensions
  Php::Extension <| |>
    # Configure extensions
    -> Php::Config <| |>
    # Reload webserver
    ~> Service["php5-fpm"]
    ~> Service["apache2"]
  
}
