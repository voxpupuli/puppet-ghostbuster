require 'puppet-ghostbuster/util'

class PuppetLint::Checks
  def load_data(path, content)
    lexer = PuppetLint::Lexer.new
    PuppetLint::Data.path = path
    begin
      PuppetLint::Data.manifest_lines = content.split("\n", -1)
      PuppetLint::Data.tokens = lexer.tokenise(content)
      PuppetLint::Data.parse_control_comments
    rescue StandardError
      PuppetLint::Data.tokens = []
    end
  end
end

PuppetLint.new_check(:ghostbuster_facts) do
  def manifests
    Dir.glob('./**/manifests/**/*.pp')
  end

  def templates
    Dir.glob('./**/templates/**/*').select { |f| File.file? f }
  end

  def check
    m = path.match(%r{.*/([^/]+)/lib/facter/(.+)$})
    return if m.nil?

    File.foreach(path) do |line|
      if line =~ /Facter.add\(["':](?<fact>[^"'\)]+)["']?\)/
        fact_name = Regexp.last_match(:fact)

        found = false

        manifests.each do |manifest|
          found = true unless PuppetGhostbuster::Util.search_file(manifest, /(\$\{?::#{fact_name}\}?|@#{fact_name})/).nil?
          break if found
        end

        templates.each do |template|
          found = true unless PuppetGhostbuster::Util.search_file(template, /@#{fact_name}/).nil?
          break if found
        end

        next if found

        notify :warning, {
          message: "Fact #{fact_name} seems unused",
          line: 1,
          column: 1,
        }
      end
    end
  end
end
