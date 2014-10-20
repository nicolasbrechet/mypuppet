class site::profiles::apache {
  class { 'apache': 
  }
  
  create_resources(apache::vhost, hiera_hash('apache_vhosts', {}))
}