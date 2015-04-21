require 'json'
require 'puppet'
require 'puppetdb'

require 'puppet_dead_code_cleaner/version'
require 'puppet_dead_code_cleaner/bin'

class PuppetDeadCodeCleaner

  def self.cache
    "/var/tmp/puppet_dead_code_cleaner.cache"
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
    Puppet.initialize_settings
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
    Dir["./**/*.pp"].each do |file|
      if c = File.readlines(file).grep(/^class\s+([^\s\(\{]+)/){$1}[0]
        class_name = c.split('::').map(&:capitalize).join('::')
        #p "class_name=#{class_name}"
        #p used_classes.include? class_name
        count = self.class.used_classes.select { |klass| klass == class_name }.size
        puts "#{count} #{class_name}"
      end
    end
  end

end
