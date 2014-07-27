class site::roles::base {
  #notify {"Environment : $::environment": }
  include site::profiles::base
}
