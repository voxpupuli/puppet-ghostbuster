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
    Dir['./**/templates/*'].each do |template|
      next unless File.file?(template)
      module_name, template_name = template.match(/.*\/([^\/]+)\/templates\/(.+)$/).captures
      found = false
      Dir["./**/manifests/**/*.pp"].each do |manifest|
        if match = manifest.match(/.*\/([^\/]+)\/manifests\/.+$/)
          manifest_module_name = match.captures[0]
          found = File.readlines(manifest).grep(/["']\$\{module_name\}\/#{template_name}["']/).size > 0 if manifest_module_name == module_name
          break if found
        end
        found = File.readlines(manifest).grep(/["']#{module_name}\/#{template_name}["']/).size > 0
        break if found
      end
      puts "#{template} not used" unless found
    end
    Dir['./**/files/*'].each do |file|
      next unless File.file?(file)
      module_name, file_name = file.match(/.*\/([^\/]+)\/files\/(.+)$/).captures
      found = false
      Dir["."].each do |caller_file|
        next unless File.file?(caller_file)
        if caller_file =~ /\.pp$/
          if match = manifest.match(/.*\/([^\/]+)\/manifests\/.+$/)
            manifest_module_name = match.captures[0]
            if manifest_module_name == module_name
              found = File.readlines(caller_file).grep(/["']\$\{module_name\}\/#{file_name}["']/).size > 0
              break if found
            end
          end
        end
        found = File.readlines(caller_file).grep(/#{module_name}\/#{file_name}/).size > 0
        break if found
      end
      puts "#{file} not used" unless found
    end
  end

end
