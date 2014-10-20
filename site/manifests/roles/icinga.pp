class site::roles::icinga inherits site::roles::base {
  #include site::profiles::icinga::server
  #include site::profiles::icinga::agent
  #include site::profiles::puppet::agent
}
