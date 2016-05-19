class PuppetLint::Checks
  def load_data(path, content)
    lexer = PuppetLint::Lexer.new
    PuppetLint::Data.path = path
    begin
      PuppetLint::Data.manifest_lines = content.split("\n", -1)
      PuppetLint::Data.tokens = lexer.tokenise(content)
      PuppetLint::Data.parse_control_comments
    rescue
      PuppetLint::Data.tokens = []
    end
  end
end

PuppetLint.new_check(:ghostbuster_facts) do
  def manifests
    Dir.glob('./**/manifests/**/*.pp')
  end

  def templates
    Dir.glob('./**/templates/**/*').select{ |f| File.file? f }
  end

  def check
    m = path.match(%r{.*/([^/]+)/lib/facter/(.+)$})
    return if m.nil?

    File.readlines(path).grep(%r{Facter.add\(["']([^"']+)["']\)}).each do |line|
      fact_name = line.match(%r{Facter.add\(["']([^"']+)["']\)}).captures[0]

      found = false

      manifests.each do |manifest|
        found = true if File.readlines(manifest).grep(%r{\$\{?::#{fact_name}\}?}).size > 0
        found = true if File.readlines(manifest).grep(%r{@#{fact_name}}).size > 0
        break if found
      end

      templates.each do |template|
        found = true if File.readlines(template).grep(%r{@#{fact_name}}).size > 0
        break if found
      end

      unless found
        notify :warning, {
          :message => "Fact #{fact_name} seems unused",
          :line    => 1,
          :column  => 1,
        }
      end
    end

  end
end
