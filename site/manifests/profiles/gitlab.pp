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
    gitlab_http_port        => '1080',
    gitlab_ssl_port         => '443',
		git_email								=> "gitlab@nicolasbrechet.com",
	  gitlab_domain     			=> 'gitlab.nicolasbrechet.com',
		gitlab_branch						=> '7-1-stable',
		gitlabshell_branch			=> 'v1.9.6',
	  gitlab_dbtype     			=> 'mysql',
	  gitlab_dbname     			=> $gitlab_dbname,
	  gitlab_dbuser     			=> $gitlab_dbuser,
	  gitlab_dbpwd      			=> $gitlab_dbpwd,			                  			
		gitlab_ssl      				=> true,
		gitlab_ssl_cert   			=> "/etc/ssl/certs/ssl-cert-snakeoil.pem",
		gitlab_ssl_key    			=> "/etc/ssl/private/ssl-cert-snakeoil.key",
		gitlab_ssl_self_signed	=> false,
		ldap_enabled    				=> false,
		ldap_host    						=> "ldap.domain.com",
		ldap_base    						=> "dc=domain,dc=com",
		ldap_uid 			   				=> "uid",
		ldap_port		    				=> 636,
		ldap_method 	   				=> "ssl",
		ldap_bind_dn    				=> "some_username",
		ldap_bind_password   		=> "password",
	}
  
	Class['gitlab_requirements'] -> Class['gitlab']
}
