# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "puppet-ghostbuster/version"

Gem::Specification.new do |s|
  s.name        = "puppet-ghostbuster"
  s.version     = PuppetGhostbuster::VERSION
  s.authors     = ["Camptocamp"]
  s.homepage    = "http://github.com/camptocamp/puppet-ghostbuster"
  s.summary     = "Dead code detector for Puppet"
  s.description = "Try and find dead code in Puppet receipts"
  s.licenses    = 'Apache-2.0'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'github_changelog_generator'
  s.add_runtime_dependency 'json'
  s.add_runtime_dependency 'puppet'
  s.add_runtime_dependency 'puppetdb-ruby'
end
