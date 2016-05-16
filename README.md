puppet-ghostbuster
==================

[![Build Status](https://img.shields.io/travis/camptocamp/puppet-ghostbuster.svg)](https://travis-ci.org/camptocamp/puppet-ghostbuster)
[![Gem Version](https://img.shields.io/gem/v/puppet-ghostbuster.svg)](https://rubygems.org/gems/puppet-ghostbuster)
[![Gem Downloads](https://img.shields.io/gem/dt/puppet-ghostbuster.svg)](https://rubygems.org/gems/puppet-ghostbuster)
[![Gemnasium](https://img.shields.io/gemnasium/camptocamp/puppet-ghostbuster.svg)](https://gemnasium.com/camptocamp/puppet-ghostbuster)

When you have dead puppet code hanging around ...
*Who you gonna call ?*


This gems helps puppet users to find dead code by displaying unused classes, defined resources, template and files.

This gems only support PuppetDB APi v4 (PuppetDB 3+)

Usage
-----

```shell
$ find . -type f -exec puppet-lint --only-checks ghostbuster_classes,ghostbuster_defines,ghostbuster_facts,ghostbuster_files,ghostbuster_functions,ghostbuster_hiera_files,ghostbuster_templates,ghostbuster_types {} \+
```

Environment variables
---------------------

### HIERA_YAML_PATH

The location of the `hiera.yaml` file. Defaults to `/etc/puppetlabs/code/hiera.yaml`

### PUPPETDB_URL

The url or the PuppetDB. Defaults to `http://puppetdb:8080`

### PUPPETDB_CACERT_FILE

Your site’s CA certificate

### PUPPETDB_CERT_FILE

An SSL certificate signed by your site’s Puppet CA

### PUPPETDB_KEY_FILE

The private key for that certificate

Plugins
-------

### ghostbuster_classes

Find unused classes in PuppetDB.

### ghostbuster_defines

Find unused defined types in PuppetDB.

### ghostbuster_facts

Find unused facts in Puppet manifests and templates.

### ghostbuster_files

Find unused files in PuppetDB or in Puppet manifests.

### ghsotbuster_functions

Find unused functions in Puppet manifests or templates.

### ghostbuster_hiera_files

Find unused hiera files in PuppetDB.

### ghostbuster_templates

Find unused templates in Puppet manifests.

### ghostbuster_types

Find unused types in Puppet manifests.

Example output
--------------

TODO
```
$ find . -type f -exec puppet-lint --only-checks ghostbuster_classes,ghostbuster_defines,ghostbuster_files,ghostbuster_hiera_files,ghostbuster_templates {} \+
./modules/foo/manifests/install.pp - WARNING: Class Foo::Install seems unused on line 1
./modules/foo/manifests/service.pp - WARNING: Class Foo::Service seems unused on line 1
./modules/foo/manifests/init.pp - WARNING: Class Foo seems unused on line 1
./modules/bar/manifests/baz.pp - WARNING: Define Bar::Baz seems unused on line 1
./modules/modulename/templates/foo.erb - WARNING: Template modulename/foo.erb seems unused on line 1
./modules/modulename/templates/bar.erb - WARNING: Template modulename/bar.erb seems unused on line 1
./modules/modulename/templates/baz.erb - WARNING: Template modulename/baz.erb seems unused on line 1
./modules/foo/files/bar.txt - WARNING: File foo/bar.txt seems unused on line 1
./modules/foo/files/baz.txt - WARNING: File foo/baz.txt seems unused on line 1
```
