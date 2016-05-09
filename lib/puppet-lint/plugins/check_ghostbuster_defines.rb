require 'puppetdb'

PuppetLint.new_check(:ghostbuster_defines) do

  def self.client
    @@client ||= PuppetDB::Client.new({
      :server => "#{ENV['PUPPETDB_URL'] || 'http://puppetdb:8080'}/pdb/query",
      :pem    => {
        'key'     => ENV['PUPPETDB_KEY_FILE'],
        'cert'    => ENV['PUPPETDB_CERT_FILE'],
        'ca_file' => ENV['PUPPETDB_CACERT_FILE'],
      }
    }, 4)
  end

  def check
    return if path.match(%r{.*/([^/]+)/manifests/(.+)$}).nil?

    defined_type_indexes.each do |define_idx|
      title_token = define_idx[:name_token]
      type = title_token.value.split('::').map(&:capitalize).join('::')

      return if self.class.client.request('resources', [:'=', 'type', type]).data.size > 0

      notify :warning, {
        :message => "Define #{type} seems unused",
        :line    => title_token.line,
        :column  => title_token.column,
      }
    end
  end
end

