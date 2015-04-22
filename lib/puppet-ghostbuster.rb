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

  def find_unused_classes
    Dir["./**/manifests/**/*.pp"].each do |file|
      if c = File.readlines(file).grep(/^class\s+([^\s\(\{]+)/){$1}[0]
        class_name = c.split('::').map(&:capitalize).join('::')
        count = self.class.used_classes.select { |klass| klass == class_name }.size
        puts "Class #{class_name} not used" if count == 0
      end
    end
  end

  def find_unused_defines
    Dir["./**/manifests/**/*.pp"].each do |file|
      if d = File.readlines(file).grep(/^define\s+([^\s\(\{]+)/){$1}[0]
        define_name = d.split('::').map(&:capitalize).join('::')
        count = self.class.client.request('resources', [:'=', 'type', define_name]).data.size
        puts "Define #{define_name} not used" if count == 0
      end
    end
  end

  def find_unused_templates
    Dir['./**/templates/*'].each do |template|
      next unless File.file?(template)
      module_name, template_name = template.match(/.*\/([^\/]+)\/templates\/(.+)$/).captures
      count = 0
      Dir["./**/manifests/**/*.pp"].each do |manifest|
        if match = manifest.match(/.*\/([^\/]+)\/manifests\/.+$/)
          manifest_module_name = match.captures[0]
          count += File.readlines(manifest).grep(/["']\$\{module_name\}\/#{template_name}["']/).size if manifest_module_name == module_name
        end
        count += File.readlines(manifest).grep(/["']#{module_name}\/#{template_name}["']/).size
      end
      puts "Template #{template} not used" if count == 0
    end
  end

  def find_unused_files
    Dir['./**/files/*'].each do |file|
      next unless File.file?(file)
      module_name, file_name = file.match(/.*\/([^\/]+)\/files\/(.+)$/).captures
      count = 0
      Dir["."].each do |caller_file|
        next unless File.file?(caller_file)
        if caller_file =~ /\.pp$/
          if match = manifest.match(/.*\/([^\/]+)\/manifests\/.+$/)
            manifest_module_name = match.captures[0]
            if manifest_module_name == module_name
              count += File.readlines(caller_file).grep(/["']\$\{module_name\}\/#{file_name}["']/).size
            end
          end
        end
        count += File.readlines(caller_file).grep(/#{module_name}\/#{file_name}/).size
      end
      puts "File #{file} not used" if count == 0
    end
  end

  def initialize
    Puppet.initialize_settings
    find_unused_classes
    find_unused_defines
    find_unused_templates
    find_unused_files
  end

end
