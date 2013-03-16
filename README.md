# puppetmodules

Modules for the Configuration Management System Puppet

This is my repository for sharing puppet modules. I hope some of the modules
are useful for other puppet users to.

## ppa

The module contains to defines to manage the handling of ppa repositories
in ubuntu.

The define ppa:repo manages the corresponding .list file for the ppa in the
apt configuration.

The define ppa:key ensures the import and remove of the GPG key for the
ppa.
