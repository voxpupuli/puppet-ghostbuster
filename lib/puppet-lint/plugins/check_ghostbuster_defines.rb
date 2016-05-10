require 'puppet-ghostbuster/puppetdb'

PuppetLint.new_check(:ghostbuster_defines) do
  def check
    return if path.match(%r{^\./(:?[^/]+/){2}?manifests/.+$}).nil?

    puppetdb = PuppetGhostbuster::PuppetDB.new

    defined_type_indexes.each do |define_idx|
      title_token = define_idx[:name_token]
      type = title_token.value.split('::').map(&:capitalize).join('::')

      return if puppetdb.client.request('resources', [:'=', 'type', type]).data.size > 0

      notify :warning, {
        :message => "Define #{type} seems unused",
        :line    => title_token.line,
        :column  => title_token.column,
      }
    end
  end
end

