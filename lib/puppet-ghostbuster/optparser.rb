require 'optparse'

# Public: Contains the puppet-ghostbuster option parser so that it can be used easily
# in multiple places.
class PuppetGhostbuster::OptParser
  HELP_TEXT = <<-EOF
    puppet-ghostbuster

    Basic Command Line Usage:
      puppet-ghostbuster [OPTIONS] [PATH]

            PATH        Path to the Root directory of puppet code. Current dir by default.

    Option:
  EOF

  # Public: Initialise a new puppet-ghostbuster OptionParser.
  #
  # Returns an OptionParser object.
  def self.build
    OptionParser.new do |opts|
      opts.banner = HELP_TEXT

      opts.on('--version', 'Display the current version.') do
        PuppetGhostbuster.configuration.display_version = true
      end

      opts.on('-c', '--config FILE', 'Load puppet-ghostbuster options from file.') do |file|
        opts.load(file)
      end

      opts.on('--log-level LEVEL', [:debug, :info, :warn, :error],
              'The level of verbosity (debug, info, warn or error)') do |loglevel|
        PuppetGhostbuster.configuration.loglevel=Logger::DEBUG if loglevel==:debug
        PuppetGhostbuster.configuration.loglevel=Logger::INFO  if loglevel==:info
        PuppetGhostbuster.configuration.loglevel=Logger::WARN  if loglevel==:warn
        PuppetGhostbuster.configuration.loglevel=Logger::ERROR if loglevel==:error
      end

      opts.on('-s', '--puppetdburl SERVER',
              'puppet db server url to connect to.',
              'Defaults to the puppet server found in puppet configuration') do |s|
        PuppetGhostbuster.configuration.puppetdbserverurl = s
      end

      opts.on('--key FILE', 'Load private key from the given file.') do |file|
        PuppetGhostbuster.configuration.hostprivkey
      end

      opts.on('--cert FILE', 'Load cert from the given file.') do |file|
        PuppetGhostbuster.configuration.hostcert
      end

      opts.on('--ca FILE', 'Load local ca cert from the given file.') do |file|
        PuppetGhostbuster.configuration.localcacert
      end

      opts.load('/etc/puppet-ghostbuster.rc')
      begin
        opts.load(File.expand_path('~/.puppet-ghostbuster.rc')) if ENV['HOME']
      rescue Errno::EACCES
        # silently skip loading this file if HOME is set to a directory that
        # the user doesn't have read access to.
      end
      opts.load('.puppet-ghostbuster.rc')
    end
  end
end
