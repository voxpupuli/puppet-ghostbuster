PuppetLint.new_check(:ghostbuster_types) do
  def manifests
    Dir.glob('./**/manifests/**/*.pp')
  end

  def check
    m = path.match(%r{.*/[^/]+/lib/puppet/type/(.+)\.rb$})
    return if m.nil?

    type_name = m.captures[0]

    manifests.each do |manifest|
      return if File.readlines(manifest).grep(%r{^\s*#{type_name}\s*\{}).size > 0
    end

    notify :warning, {
      :message => "Type #{type_name.capitalize} seems unused",
      :line    => 1,
      :column  => 1,
    }
  end
end
