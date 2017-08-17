require 'puppetdb'

class PuppetGhostbuster
  class PuppetDB
    def self.client
      @@client ||= ::PuppetDB::Client.new({
        :server => "#{ENV['PUPPETDB_URL'] || 'http://puppetdb:8080'}/pdb/query",
        :pem    => {
          'key'     => ENV['PUPPETDB_KEY_FILE'],
          'cert'    => ENV['PUPPETDB_CERT_FILE'],
          'ca_file' => ENV['PUPPETDB_CACERT_FILE'],
        }
      }, 4)
    end

    def client
      self.class.client
    end

    def self.classes
      @@classes ||= client.request('', 'resources[title] { type = "Class" and nodes { deactivated is not null } }').data.map { |r| r['title'] }.uniq
    end

    def classes
      self.class.classes
    end

    def self.resources
      @@resources ||= client.request('', 'resources[title] { nodes { deactivated is not null } }').data.map { |r| r['title'] }.uniq
    end

    def resources
      self.class.resources
    end
  end
end
