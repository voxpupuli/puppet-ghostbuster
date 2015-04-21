class PuppetDeadCodeCleaner::Bin
  def initialize(args)
    @args = args
  end

  def run
    PuppetDeadCodeCleaner.new
    exit 0
  end
end
