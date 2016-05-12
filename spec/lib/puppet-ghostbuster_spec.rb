module PuppetGhostbusterSpec
  class PuppetDBRequest
    def initialize(data)
      @data = data
    end

    def data
      @data
    end
  end

  def expect_puppetdb_nodes(request, data)
    expect_any_instance_of(PuppetDB::Client).to \
      receive(:request).with('nodes', request)
    .and_return(PuppetDBRequest.new(data))
  end

  def expect_puppetdb_resources(request, data)
    expect_any_instance_of(PuppetDB::Client).to \
      receive(:request).with('resources', request)
    .and_return(PuppetDBRequest.new(data))
  end
end
