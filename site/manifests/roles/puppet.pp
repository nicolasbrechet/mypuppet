class site::roles::puppet::master inherits site::roles::base {
  include site::profiles::puppet::master
  #include site::profiles::puppet::agent
}
