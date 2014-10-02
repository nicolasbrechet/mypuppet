class site::roles::monitoring_server inherits site::roles::base {
  include site::profiles::monitoring_server
  include site::profiles::puppet::agent
}
