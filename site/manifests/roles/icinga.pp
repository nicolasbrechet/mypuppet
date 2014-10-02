class site::roles::icinga inherits site::roles::base {
  include site::profiles::icinga
  include site::profiles::puppet::agent
}
