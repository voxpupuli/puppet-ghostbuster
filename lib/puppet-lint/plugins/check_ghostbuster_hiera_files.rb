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

PuppetLint.new_check(:ghostbuster_hiera_files) do

  def regexprs
    hiera_yaml_file = ENV['HIERA_YAML_PATH'] || '/etc/puppetlabs/code/hiera.yaml'
    hiera = YAML.load_file(hiera_yaml_file)
    regs = {}
    hiera[:hierarchy].each do |hierarchy|
      regex = hierarchy.gsub(/%\{(::)?(trusted|server_facts|facts)\.[^\}]+\}/, "(.+)").gsub(/%\{[^\}]+\}/, ".+")
      facts = hierarchy.match(regex).captures.map { |f| f[/%{(::)?(trusted|server_facts|facts)\.(.+)}/, 3] }
      regs[regex] = facts
    end
    regs
  end

  def check
    return if path.match(%r{./hieradata/.*\.yaml}).nil?

    puppetdb = PuppetGhostbuster::PuppetDB.new
    _path = path.gsub("./hieradata/", "")

    regexprs.each do |k, v|
      m = _path.match(Regexp.new "#{k}\.yaml")
      next if m.nil?
      return if m.captures.size == 0

      if m.captures.size > 1
        i = 0
        query = [:'and']
        m.captures.map do |value|
          if v[i] == 'certname'
            query << [:'=', v[i], value]
          else
            query << [:'=', ['fact', v[i]], value]
          end
          i += 1
        end
      else
        if v[0] == 'certname'
          query = [:'=', 'certname', m.captures[0]]
        else
          value = if m.captures[0] == 'true'
                    true
                  elsif m.captures[0] == 'false'
                    false
                  else
                    m.captures[0]
                  end
          query = [:'=', ['fact', v[0]], value]
        end
      end

      return if puppetdb.client.request('nodes', query ).data.size > 0
    end

    notify :warning, {
      :message => "Hiera File #{_path} seems unused",
      :line    => 1,
      :column  => 1,
    }
  end
end
