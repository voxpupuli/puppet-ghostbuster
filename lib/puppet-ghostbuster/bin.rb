class PuppetGhostbuster::Bin
  def initialize(args)
    @args = args
  end

  def run
    PuppetGhostbuster.new
    exit 0
  end
end
