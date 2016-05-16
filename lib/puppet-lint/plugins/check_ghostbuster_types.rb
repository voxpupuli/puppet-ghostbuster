require 'puppet-ghostbuster/puppetdb'

PuppetLint.new_check(:ghostbuster_types) do
  def manifests
    Dir.glob('./**/manifests/**/*.pp')
  end

  def check
    m = path.match(%r{.*/[^/]+/lib/puppet/type/(.+)\.rb$})
    return if m.nil?

    type_name = m.captures[0]

    puppetdb = PuppetGhostbuster::PuppetDB.new
    return if puppetdb.client.request('resources', [:'=', 'type', type_name.capitalize]).data.size > 0

    notify :warning, {
      :message => "Type #{type_name.capitalize} seems unused",
      :line    => 1,
      :column  => 1,
    }
  end
end
