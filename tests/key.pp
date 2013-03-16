import '../manifests/key'

ppa::key { '7CC17CD2':
  ensure => present,
}

ppa::key { '02D65EFF':
  ensure => absent,
}
