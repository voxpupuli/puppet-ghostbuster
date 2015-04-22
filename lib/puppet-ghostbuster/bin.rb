require 'puppet-ghostbuster/optparser'
class PuppetGhostbuster::Bin
  def initialize(args)
    @args = args
  end

  def run
    opts = PuppetGhostbuster::OptParser.build

    begin
      opts.parse!(@args)
    rescue OptionParser::InvalidOption
      puts "puppet-ghostbuster: #{$!.message}"
      puts "puppet-ghostbuster: try 'puppet-ghostbuster --help' for more information"
      return 1
    end

    if PuppetGhostbuster.configuration.display_version
      puts "puppet-ghostbuster #{PuppetGhostbuster::VERSION}"
      return 0
    end
   
    if @args[0].nil?
      PuppetGhostbuster.new().run
    else
      PuppetGhostbuster.new(@args[0]).run
    end

    exit 0
  end
end
