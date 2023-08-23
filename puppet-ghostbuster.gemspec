$LOAD_PATH.unshift File.expand_path('lib', __dir__)
require 'puppet-ghostbuster/version'

Gem::Specification.new do |s|
  s.name        = 'puppet-ghostbuster'
  s.version     = PuppetGhostbuster::VERSION
  s.authors     = ['Camptocamp', 'Vox Pupuli']
  s.homepage    = 'http://github.com/voxpupuli/puppet-ghostbuster'
  s.summary     = 'Dead code detector for Puppet'
  s.description = 'Try and find dead code in Puppet receipts'
  s.licenses    = 'Apache-2.0'

  s.files       = `git ls-files`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }

  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'github_changelog_generator'
  s.add_development_dependency 'jgrep'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'rspec-collection_matchers', '~> 1.0'
  s.add_development_dependency 'rspec-its', '~> 1.0'
  s.add_runtime_dependency 'json'
  s.add_runtime_dependency 'puppet'
  s.add_dependency         'puppet-lint', '>= 1.0', '< 3.0'
  s.add_runtime_dependency 'puppetdb-ruby', '~> 1.1', '>= 1.1.1'
end
