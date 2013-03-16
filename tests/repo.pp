import '../manifests/repo'

ppa::repo { 'blueyed/ppa':
  ensure  => present,
  apt_key => '7CC17CD2',
}

ppa::repo { 'linrunner/tlp':
  ensure  => absent,
  apt_key => '02D65EFF',
}
