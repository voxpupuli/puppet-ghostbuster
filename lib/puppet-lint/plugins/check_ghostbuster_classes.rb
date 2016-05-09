require 'puppetdb'

PuppetLint.new_check(:ghostbuster_classes) do

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

  def self.classes
    @@classes ||= client.request('resources', [:'=', 'type', 'Class']).data.map { |r| r['title'] }.uniq
  end

  def check
    return if path.match(%r{.*/([^/]+)/manifests/(.+)$}).nil?

    class_indexes.each do |class_idx|
      title_token = class_idx[:name_token]
      title = title_token.value.split('::').map(&:capitalize).join('::')

      return if self.class.classes.include? title

      notify :warning, {
        :message => "Class #{title} seems unused",
        :line    => title_token.line,
        :column  => title_token.column,
      }
    end
  end
end
