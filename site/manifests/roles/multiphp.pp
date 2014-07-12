class site::roles::multiphp inherits site::roles::base {
  notify {"Environment : $::environment": }
  include site::profiles::multiphp
}
