# ppa

This puppet module provides defines to manage personal package archives (ppa)
in ubuntu.

There will be a failure if you try to use the defines with a distribution
other than ubuntu or one of it's derivates.

## ppa::repo

With this define you are able to add or remove a ppa to your configuration. If
you define a gpg key for the ppa, this key will be imported by the ppa::key
define.

## ppa::key

The define is used to add or remove the gpg key of a ppa to the apt keystore.
The key will be retrieved from the ubuntu keystore. It's possible to define
a different keystore.
