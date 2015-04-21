# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "puppet_dead_code_cleaner/version"

Gem::Specification.new do |s|
  s.name        = "puppet_dead_code_cleaner"
  s.version     = PuppetDeadCodeCleaner::VERSION
  s.authors     = ["Camptocamp"]
  s.homepage    = "http://github.com/camptocamp/puppet_dead_code_cleaner"
  s.summary     = "Dead code detector for Puppet"
  s.description = "Try and find dead code in Puppet receipts"
  s.licenses    = 'Apache-2.0'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.add_runtime_dependency 'json'
  s.add_runtime_dependency 'puppet'
  s.add_runtime_dependency 'puppetdb-ruby'
end
