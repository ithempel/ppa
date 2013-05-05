# ppa

This puppet module provides defines to manage personal package archives (ppa)
in ubuntu.

There will be a failure if you try to use the defines with a distribution
other than ubuntu or one of it's derivates.

## ppa::repo

With this define you are able to add or remove a ppa to your configuration. If
you define a gpg key for the ppa, this key will be imported by the ppa::key
define.

### Parameters

**namevar**
   The name of the resource is the name of the ppa repository to add.
   The name of the ppa repository is the part after the ppa: string. The rule
   for the ppa name is 'user/ppaname'; e.g. 'blueyed/ppa'. The default for the
   ppaname is ppa.

**ensure**
   The default value is 'present' to add the ppa repository to the
   installation. The value 'absent' can be used to remove the ppa repository
   from the configuration.

**apt_key**
   Hashcode of the apt-key of the ppa repository. The key will be retrieved
   and added to the repository of apt-keys.

**comment**
   Optional comment / remark for the ppa repository to be stored in the
   repository definition file.

**dist**
   Name of the distribution for which to retrieve the files from the
   repository. The default value for the attribute dist will be the value of
   the facter / variable lsbdistcodename.

**supported**
   List of supported distributions. If the value of the attribute dist is not
   contained the definition will remove the corresponding ppa repository
   definition.

**keyserver**
   Server from which the apt_key should be retrieved. The default of this
   attribute is keyserver.ubuntu.com.

### Examples

```
ppa::repo { 'blueyed/ppa':
  apt_key => '7CC17CD2'
}

ppa::repo { 'blueyed/ppa':
  ensure => present,
}

ppa::repo { 'blueyed/ppa':
  ensure => absent,
}
```

## ppa::key

The define is used to add or remove the gpg key of a ppa to the apt keystore.
The key will be retrieved from the ubuntu keystore. It's possible to define
a different keystore.

### Parameters

**namevar**
  The name of the resource is the unique number of the key to be added.

**ensure**
  With the value 'present' the given key will be listed in the key store for
  apt. If the value is 'absent' the key will be removed from the key store.

**keyserver**
  The name of the server to retrieve the give from. The default key server is
  keyserver.ubuntu.com.

### Examples

```
ppa::key { '7CC17CD2':
}

ppa::key { '7CC17CD2':
  ensure => present,
}

ppa::key { '7CC17CD2':
  ensure => absent,
}
```
