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

PuppetLint.new_check(:ghostbuster_templates) do
  def manifests
    Dir.glob('./**/manifests/**/*.pp')
  end

  def templates
    Dir.glob('./**/templates/**/*').select { |f| File.file? f }
  end

  def check
    m = path.match(%r{.*/([^/]+)/templates/(.+)$})
    return if m.nil?

    module_name, template_name = m.captures

    manifests.each do |manifest|
      return if PuppetGhostbuster::Util.search_file(manifest, %r{["']#{module_name}/#{template_name}["']})

      next unless match = manifest.match(%r{.*/([^/]+)/manifests/.+$})

      if match.captures[0] == module_name && PuppetGhostbuster::Util.search_file(manifest, %r{["']\$\{module_name\}/#{template_name}["']})
        return
      end
    end

    templates.each do |template|
      return if PuppetGhostbuster::Util.search_file(template, "scope.function_template(['#{module_name}/#{template_name}'])")
    end

    notify :warning, {
      message: "Template #{module_name}/#{template_name} seems unused",
      line: 1,
      column: 1,
    }
  end
end
