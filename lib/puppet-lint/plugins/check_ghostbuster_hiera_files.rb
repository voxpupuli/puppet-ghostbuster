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

PuppetLint.new_check(:ghostbuster_hiera_files) do
  def hiera
    @hiera ||= YAML.load_file(ENV['HIERA_YAML_PATH'] || '/etc/puppetlabs/code/hiera.yaml')
  end

  def default_datadir
    hiera.dig('defaults', 'datadir') || 'hieradata'
  end

  def path_in_datadirs?(path)
    @data_dirs ||= hiera['hierarchy'].map { |h| (h['datadir'] || default_datadir).chomp('/') }.uniq
    path.match?(%(./#{Regexp.union(@data_dirs)}/))
  end

  def regexprs
    regs = {}
    hiera['hierarchy'].each do |hierarchy|
      path_datadir = Regexp.escape((hierarchy['datadir'] || default_datadir).chomp('/'))
      ([*hierarchy['path']] + [*hierarchy['paths']]).each do |level|
        level = File.join(path_datadir, level)
        regex = Regexp.new(level.gsub(/%\{(::)?(trusted|server_facts|facts)\.[^\}]+\}/, '(.+)').gsub(/%\{[^\}]+\}/, '.+'))
        facts = level.match(regex).captures.map { |f| f[/%{(::)?(trusted|server_facts|facts)\.(.+)}/, 3] }
        regs[regex] = facts
      end
    end
    regs
  end

  def check
    return unless path_in_datadirs? path

    puppetdb = PuppetGhostbuster::PuppetDB.new

    regexprs.each do |k, v|
      m = path.match(k)
      next if m.nil?

      return if m.captures.size == 0

      if m.captures.size > 1
        i = 0
        query = [:and]
        m.captures.map do |value|
          query << if v[i] == 'certname'
                     [:'=', v[i], value]
                   else
                     [:'=', ['fact', v[i]], value]
                   end
          i += 1
        end
      elsif v[0] == 'certname'
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

      query = [:and, query, [:'=', 'deactivated', nil]]

      return if puppetdb.client.request('nodes', query).data.size > 0
    end

    notify :warning, {
      message: "Hiera File #{path} seems unused",
      line: 1,
      column: 1,
    }
  end
end
