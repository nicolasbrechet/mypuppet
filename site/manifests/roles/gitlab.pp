class site::roles::gitlab inherits site::roles::base {
  include site::profiles::gitlab
  include site::profiles::puppet::agent
}
