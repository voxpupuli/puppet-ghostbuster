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

PuppetLint.new_check(:ghostbuster_defines) do
  def check
    return if path.match(%r{^\./(:?[^/]+/){2}?manifests/.+$}).nil?

    puppetdb = PuppetGhostbuster::PuppetDB.new

    defined_type_indexes.each do |define_idx|
      title_token = define_idx[:name_token]
      type = title_token.value.split('::').map(&:capitalize).join('::')

      return if puppetdb.resources.include? type

      notify :warning, {
        :message => "Define #{type} seems unused",
        :line    => title_token.line,
        :column  => title_token.column,
      }
    end
  end
end

