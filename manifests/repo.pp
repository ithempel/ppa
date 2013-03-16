# == Define: ppa::repo
#
# The define ppa::repo is used to configure additional ppa repositories.
#
# The definition of the pparepo resource is based on the definition of Daniel
# Hahler
# http://daniel.hahler.de/puppet-definition-to-add-launchpad-ppa-repository.
#
# === Parameters
#
# [*namevar*]
#   The name of the resource is the name of the ppa repository to add.
#   The name of the ppa repository is the part after the ppa: string. The rule
#   for the ppa name is 'user/ppaname'; e.g. 'blueyed/ppa'. The default for the
#   ppaname is ppa.
#
# [*ensure*]
#   The default value is 'present' to add the ppa repository to the
#   installation. The value 'absent' can be used to remove the ppa repository
#   from the configuration.
#
# [*apt_key*]
#   Hashcode of the apt-key of the ppa repository. The key will be retrieved
#   and added to the repository of apt-keys.
#
# [*comment*]
#   Optional comment / remark for the ppa repository to be stored in the
#   repository definition file.
#
# [*dist*]
#   Name of the distribution for which to retrieve the files from the
#   repository. The default value for the attribute dist will be the value of
#   the facter / variable lsbdistcodename.
#
# [*supported*]
#   List of supported distributions. If the value of the attribute dist is not
#   contained the definition will remove the corresponding ppa repository
#   definition.
#
# [*keyserver*]
#   Server from which the apt_key should be retrieved. The default of this
#   attribute is keyserver.ubuntu.com.
#
# === Examples
#
#  ppa::repo { 'blueyed/ppa':
#    apt_key => '7CC17CD2'
#  }
#
#  ppa::repo { 'blueyed/ppa':
#    ensure => present,
#  }
#
#  ppa::repo { 'blueyed/ppa':
#    ensure => absent,
#  }
#
# === Authors
#
# Daniel Hahler @blueyed
# Sebastian Hempel <shempel@it-hempel.de>
#
# === Copyright
#
# Copyright 2011 Daniel Hahler
# Copyright 2013 Sebastian Hempel
#
define ppa::repo(
  $ensure = present,
  $apt_key = '',
  $comment = '',
  $dist = $lsbdistcodename,
  $supported = ['lucis', 'maverick', 'natty', 'oneiric', 'precise', 'quantal'],
  $keyserver = 'keyserver.ubuntu.com'
) {
  $ppa_file_name = regsubst($name, '/', '-', 'G')
  $ppa_config_file = "/etc/apt/sources.list.d/pparepo-${ppa_file_name}.list"

  file { $ppa_config_file:
  }

  case $ensure {
    present: {
      if ($dist) and ($dist in $supported) {
        File[$ppa_config_file] {
          ensure  => file,
          content => template('ppa/ppa.list.erb'),
        }
        if ($apt_key) {
          ppa::key { $apt_key:
            keyserver => $keyserver
          }
          Exec["update apt repositories for ${name}"] {
            require => ppa::key[$apt_key],
          }
        }
      }
      else {
        File[$ppa_config_file] {
          ensure => false
        }

        fail "Unsupported dist '${dist}' for pparepo ${name}"
      }
    }
    absent:  {
      File[$ppa_config_file] {
        ensure => false
      }
    }
    default: {
      fail "Invalid 'ensure' value '${ensure}' for pparepo"
    }
  }

  exec { "update apt repositories for ${name}":
    path        => '/bin:/usr/bin',
    environment => 'HOME=/root',
    command     => 'apt-get update',
    user        => 'root',
    group       => 'root',
    logoutput   => on_failure,
    subscribe   => File[$ppa_config_file],
    refreshonly => true,
  }
}
