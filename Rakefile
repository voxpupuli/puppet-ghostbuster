begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end

require 'github_changelog_generator/task'
require 'puppet-ghostbuster/version'
GitHubChangelogGenerator::RakeTask.new :changelog do |config|
  config.future_release = PuppetGhostbuster::VERSION
  config.release_url = "https://rubygems.org/gems/puppet-ghostbuster/versions/%s"
end
