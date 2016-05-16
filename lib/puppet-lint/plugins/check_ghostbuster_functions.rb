PuppetLint.new_check(:ghostbuster_functions) do
  def manifests
    Dir.glob('./**/manifests/**/*.pp')
  end

  def templates
    Dir.glob('./**/templates/**/*').select{ |f| File.file? f }
  end

  def check
    m = path.match(%r{.*/[^/]+/lib/puppet/parser/functions/(.+)\.rb$})
    return if m.nil?

    function_name = m.captures[0]

    manifests.each do |manifest|
      return if File.readlines(manifest).grep(%r{#{function_name}\(}).size > 0
    end

    templates.each do |template|
      return if File.readlines(template).grep(%r{scope.function_#{function_name}\(}).size > 0
      return if File.readlines(template).grep(%r{Puppet::Parser::Functions.function\(:#{function_name}}).size > 0
    end

    notify :warning, {
      :message => "Function #{function_name} seems unused",
      :line    => 1,
      :column  => 1,
    }
  end
end
