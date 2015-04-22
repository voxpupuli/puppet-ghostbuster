require 'json'
require 'puppet'
require 'puppetdb'

require 'puppet-ghostbuster/version'
require 'puppet-ghostbuster/bin'

class PuppetGhostbuster

  def self.cache
    "/var/tmp/puppet-ghostbuster.cache"
  end

  def self.update_cache(value)
    File.open(cache, 'w') do |f|
      f.write(value)
    end
    value
  end

  def self.get_cache
    if File.exists?(cache)
      JSON.parse(File.read(cache))
    else
      false
    end
  end

  def self.client 
    PuppetDB::Client.new({
      :server => "https://#{Puppet[:server]}:8081",
      :pem    => {
        'key'     => Puppet[:hostprivkey],
        'cert'    => Puppet[:hostcert],
        'ca_file' => Puppet[:localcacert],
      }
    })
  end


  def self.used_classes
    return get_cache || update_cache(
      client.request(
        'resources',
        [:'=', 'type', 'Class'],
      ).data.map { |resource|
        resource['title']
      }
    )
  end

  def initialize
    Puppet.initialize_settings
    Dir["./**/manifests/**/*.pp"].each do |file|
      if c = File.readlines(file).grep(/^class\s+([^\s\(\{]+)/){$1}[0]
        class_name = c.split('::').map(&:capitalize).join('::')
        count = self.class.used_classes.select { |klass| klass == class_name }.size
        puts "#{count} Class[#{class_name}]"
      elsif d = File.readlines(file).grep(/^define\s+([^\s\(\{]+)/){$1}[0]
        define_name = d.split('::').map(&:capitalize).join('::')
        count = self.class.client.request('resources', [:'=', 'type', define_name]).data.size
        puts "#{count} #{define_name}"
      end
    end
  end

end
