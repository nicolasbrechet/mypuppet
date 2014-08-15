class site::profiles::gitlab {
	$gitlab_dbname	= "nbt_gitlab_db"
	$gitlab_dbuser	= "nbt_gitlab_user"
	$gitlab_dbpwd 	= "XYHLYFstit36}]z3iYVw"

  #exec { 'initial update':
  #  command   => '/usr/bin/apt-get update',
  #}
  #
  #Exec['initial update'] -> Package <| |>

  class {'nginx':
    confd_purge => true,
  }
  
	class { 'gitlab_requirements':
	  gitlab_dbname   => $gitlab_dbname,
	  gitlab_dbuser   => $gitlab_dbuser,
	  gitlab_dbpwd    => $gitlab_dbpwd,
	}

	class { '::gitlab':
    gitlab_unicorn_port     => '18080',
		git_email								=> "gitlab@nicolasbrechet.com",
	  gitlab_domain     			=> 'gitlab.nicolasbrechet.com',
		gitlab_branch						=> '7-1-stable',
		gitlabshell_branch			=> 'v1.9.6',
    gitlab_manage_nginx     => 'false',
	  gitlab_dbtype     			=> 'mysql',
	  gitlab_dbname     			=> $gitlab_dbname,
	  gitlab_dbuser     			=> $gitlab_dbuser,
	  gitlab_dbpwd      			=> $gitlab_dbpwd,			                  			
		gitlab_ssl      				=> true,
		gitlab_ssl_cert   			=> "/etc/ssl/certs/ssl-cert-snakeoil.pem",
		gitlab_ssl_key    			=> "/etc/ssl/private/ssl-cert-snakeoil.key",
		gitlab_ssl_self_signed	=> true,
		ldap_enabled    				=> false,
	}
  
  class { 'apache':
    default_vhost => false,
  }
  
  apache::vhost { 'gitlab.nicolasbrechet.com':
    docroot => '/home/git/gitlab/public',
    ssl     => true,
    
    
  }
  
	Class['gitlab_requirements'] -> Class['gitlab']
}
