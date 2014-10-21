class site::profiles::gitlab {

  class { 'gitlab' : 
    puppet_manage_config   => true,
    puppet_manage_backups  => true,
    puppet_manage_packages => true,
    ssl_certificate        => '/etc/gitlab/ssl/gitlab.crt',
    ssl_certificate_key    => '/etc/gitlab/ssl/gitlab.key',
    redirect_http_to_https => true,
    backup_keep_time       => 5184000, # In seconds, 5184000 = 60 days
    gitlab_default_projects_limit => 100,
  }

}
