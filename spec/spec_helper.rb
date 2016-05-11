require 'puppet-lint'

require 'pathname'
dir = Pathname.new(__FILE__).parent
$LOAD_PATH.unshift(dir, File.join(dir, 'lib'), File.join(dir, '..', 'lib'))

require 'puppet-ghostbuster_spec'

PuppetLint::Plugins.load_spec_helper
