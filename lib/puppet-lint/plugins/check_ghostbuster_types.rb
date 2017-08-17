require 'puppet-ghostbuster/puppetdb'

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

PuppetLint.new_check(:ghostbuster_types) do
  def manifests
    Dir.glob('./**/manifests/**/*.pp')
  end

  def check
    m = path.match(%r{.*/[^/]+/lib/puppet/type/(.+)\.rb$})
    return if m.nil?

    type_name = m.captures[0]

    puppetdb = PuppetGhostbuster::PuppetDB.new
    return if puppetdb.resources.include? type_name.capitalize

    notify :warning, {
      :message => "Type #{type_name.capitalize} seems unused",
      :line    => 1,
      :column  => 1,
    }
  end
end
