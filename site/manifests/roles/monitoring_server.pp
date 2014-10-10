class site::roles::monitoring_server inherits site::roles::base {
  include site::profiles::icinga2_server
  include site::profiles::icinga2_web
  include site::profiles::puppet::agent
}
