class site::profiles::gitlab {
  $gitlab_dbname	= hiera('gitlab::gitlab_dbname')
  $gitlab_dbuser	= hiera('gitlab::gitlab_dbuser')
  $gitlab_dbpwd 	= hiera('gitlab::gitlab_dbpwd')
  
  class { '::gitlab_requirements':
    gitlab_dbname   => $gitlab_dbname,
    gitlab_dbuser   => $gitlab_dbuser,
    gitlab_dbpwd    => $gitlab_dbpwd,
	}
	  
  class { '::gitlab':
    git_email           => hiera('gitlab::git_email'),
    gitlab_domain       => hiera('gitlab::gitlab_domain'),
    gitlab_branch       => hiera('gitlab::gitlab_branch'),
    gitlabshell_branch  => hiera('gitlab::gitlabshell_branch'),
    gitlab_dbtype       => hiera('gitlab::gitlab_dbtype'),
    gitlab_dbname       => $gitlab_dbname,
    gitlab_dbuser       => $gitlab_dbuser,
    gitlab_dbpwd        => $gitlab_dbpwd
  }
  
  package{'bundler':
    ensure => present,
    provider => 'gem',    
  }
  
  Package['bundler'] 
  -> Class['::gitlab_requirements'] 
  -> Class['::gitlab']
}
