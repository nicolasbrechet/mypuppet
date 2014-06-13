class roles::base {
  notify {"Environment : $::environment": }
  include profiles::base
}