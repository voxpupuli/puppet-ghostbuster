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

If you want to read default options and private key from puppet configuration, this gem needs to have root (puppet) permissions.
```
sudo bundle exec puppet-ghostbuster
```

You can add preconnect command with ``-p`` and server url with ``-s``.

``-h`` or ``--help`` for full options.

Example output
--------------
```
$ puppet-ghostbuster -s https://puppetdburl:8081 | jsonpp
[
  {
    "title": "[GhostBuster] Class Foo::Install seems unused",
    "body": "./modules/foo/manifests/install.pp"
  },
  {
    "title": "[GhostBuster] Class Foo::Service seems unused",
    "body": "./modules/foo/manifests/service.pp"
  },
  {
    "title": "[GhostBuster] Class Foo seems unused",
    "body": "./modules/foo/manifests/init.pp"
  },
  {
    "title": "[GhostBuster] Define Bar:Baz seems unused",
    "body": "./modules/bar/manifests/baz.pp"
  },
  {
    "title": "[GhostBuster] Template modulename/foo.erb seems unused",
    "body": "./modules/modulename/templates/foo.erb"
  },
  {
    "title": "[GhostBuster] Template modulename/bar.erb seems unused",
    "body": "./modules/modulename/templates/bar.erb"
  },
  {
    "title": "[GhostBuster] Template modulename/baz.erb seems unused",
    "body": "./modules/modulename/templates/baz.erb"
  },
  {
    "title": "[GhostBuster] File foo/bar.txt seems unused",
    "body": "./modules/foo/files/bar.txt"
  },
  {
    "title": "[GhostBuster] File foo/baz.txt seems unused",
    "body": "./modules/foo/files/baz.txt"
  }
]
```

How It Works
------------
To find unused classes:
  1. It search puppet code recursively starting (by default) from current directory.
  2. For each .pp file found, it extract the class name
  3. Query puppetdb (using cache) to find matching class in catalogs
  4. Display the number of class, followed by the class name.

Same method applies to find unused defines.

To find template and files, it has to loop twice, so this step can be longer.

.ghostbusterignore
------------------

Puppet-ghostbuster supports `.ghostbusterignore` files with a list of path that
will be excluded from the dead code detection. Useful for upstream modules where
you are are not using everything.

Example of `.ghostbusterignore` file:

```
modules/apache
modules/mysql
modules/mcollective/templates
```
