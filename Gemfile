# frozen_string_literal: true

source ENV['GEM_SOURCE'] || 'https://rubygems.org'

gemspec

group :release, optional: true do
  gem 'faraday-retry', '~> 2.1', require: false
  gem 'github_changelog_generator', '~> 1.18', require: false
end

group :coverage, optional: ENV['COVERAGE'] != 'yes' do
  gem 'codecov', require: false
  gem 'simplecov-console', require: false
end
