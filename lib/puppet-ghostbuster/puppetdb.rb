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
      @@client ||= begin
        options = {
          server: ENV['PUPPETDB_URL'] || @@puppetdb,
        }

        if ENV['PE_TOKEN']
          token_file = File.expand_path(ENV['PE_TOKEN'])
          options[:token] = File.exist?(token_file) ? File.read(token_file) : ENV.fetch('PE_TOKEN')
          options[:cacert] = ENV['PUPPETDB_CACERT_FILE'] || Puppet[:localcacert]
        else
          options[:pem] = {
            'key' => ENV['PUPPETDB_KEY_FILE'] || Puppet[:hostprivkey],
            'cert' => ENV['PUPPETDB_CERT_FILE'] || Puppet[:hostcert],
            'ca_file' => ENV['PUPPETDB_CACERT_FILE'] || Puppet[:localcacert],
          }
        end

        ::PuppetDB::Client.new(options, 4)
      end
    end

    def client
      self.class.client
    end

    def self.classes
      @@classes ||= client.request('',
                                   'resources[title] { type = "Class" and nodes { deactivated is null } group by title }').data.map do |r|
        r['title']
      end
    end

    def classes
      self.class.classes
    end

    def self.resources
      @@resources ||= client.request('', 'resources[type] { nodes { deactivated is null } group by type }').data.map do |r|
        r['type']
      end
    end

    def resources
      self.class.resources
    end
  end
end
