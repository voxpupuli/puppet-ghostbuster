require 'puppetdb'
require 'puppet'

class PuppetGhostbuster
  class PuppetDB
    Puppet.initialize_settings

    begin
      require 'puppet/util/puppetdb'
      @@puppetdb = Puppet::Util::Puppetdb.config.server_urls[0]
    rescue LoadError
      @@puppetdb = "https://#{Puppet[:server]}:8081"
    end

    def self.client
      @@client ||= ::PuppetDB::Client.new({
                                            server: ENV['PUPPETDB_URL'] || @@puppetdb,
                                            pem: {
                                              'key' => ENV['PUPPETDB_KEY_FILE'] || Puppet[:hostprivkey],
                                              'cert' => ENV['PUPPETDB_CERT_FILE'] || Puppet[:hostcert],
                                              'ca_file' => ENV['PUPPETDB_CACERT_FILE'] || Puppet[:localcacert],
                                            },
                                          }, 4)
    end

    def client
      self.class.client
    end

    def self.classes
      @@classes ||= client.request('',
                                   'resources[title] { type = "Class" and nodes { deactivated is null } }').data.map do |r|
        r['title']
      end.uniq
    end

    def classes
      self.class.classes
    end

    def self.resources
      @@resources ||= client.request('', 'resources[type] { nodes { deactivated is null } }').data.map do |r|
        r['type']
      end.uniq
    end

    def resources
      self.class.resources
    end
  end
end
