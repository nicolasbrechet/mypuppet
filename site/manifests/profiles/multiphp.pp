class site::profiles::multiphp {
  class { 'apache': 
    default_vhost => false,
    
  }
  
  apache::mod { 'mod_proxy': }
  apache::mod { 'mod_proxy_fcgi': }
  
  apache::vhost { 'truc1.com':
    port            => '80',
    docroot         => '/var/www/html',
    custom_fragment => 'ProxyPassMatch ^/(.*\.php(/.*)?)$ fcgi://127.0.0.1:9001/var/www/html/$1'
  }
  
  apache::vhost { 'truc2.com':
    port            => '80',
    docroot         => '/var/www/html',
    custom_fragment => 'ProxyPassMatch ^/(.*\.php(/.*)?)$ fcgi://127.0.0.1:9002/var/www/html/$1'
  }
  
  apache::vhost { 'truc2.com':
    port            => '80',
    docroot         => '/var/www/html',
    custom_fragment => 'ProxyPassMatch ^/(.*\.php(/.*)?)$ fcgi://127.0.0.1:9003/var/www/html/$1'
  }
  
  include php
  class { 'php::fpm': 
    ensure => installed,
  }
  
  php::fpm::pool { 'truc1':
    listen => '127.0.0.1:9001',
  }
  
  php::fpm::pool { 'truc2':
    listen => '127.0.0.1:9002',
  }
  
  php::fpm::pool { 'truc3':
    listen => '127.0.0.1:9003',
  }
  
  create_resources('php::fpm::config',  hiera_hash('php_fpm_config', []))
  
  # Install extensions
  Php::Extension <| |>
    # Configure extensions
    -> Php::Config <| |>
    # Reload webserver
    ~> Service["apache2"]
  
}
