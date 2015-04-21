puppet-ghostbuster
==================

[![Gem Version](https://img.shields.io/gem/v/puppet-ghostbuster.svg)](https://rubygems.org/gems/puppet-ghostbuster)
[![Gem Downloads](https://img.shields.io/gem/dt/puppet-ghostbuster.svg)](https://rubygems.org/gems/puppet-ghostbuster)

Helps puppet users to find dead code by displaying how many time each class is used.

Classes used 0 time should be removed.


Usage
-----

This gem needs enough permissions to read puppet configuration files and private key.
```
sudo bundle exec puppet-ghostbuster
```

Example output
--------------
```
$ bundle exec puppet-ghostbuster
4 Profiles_c2c::Mw::Lamp
0 Profiles_c2c::Mw::Lighttpd
2 Profiles_c2c::Mw::Mysql
242 Profiles_c2c::Os::Base_debian
132 Profiles_c2c::Os::Monitoring
[...]
```
Wow, we don't seems to use Lightty anymore. Let's do some cleanup.

How It Works
------------
  1. It search puppet code recursively starting from current directory
  2. For each .pp file found, it extract the class name
  3. Query puppetdb (using cache) to find matching class in catalogs
  4. Display the number of class, followed by the class name.
