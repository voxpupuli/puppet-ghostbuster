require 'json'
require 'puppet'
require 'puppetdb'
require 'optparse'

require 'puppet-ghostbuster/version'
require 'puppet-ghostbuster/bin'
require 'puppet-ghostbuster/configuration'

class PuppetGhostbuster

  attr_accessor :path

  def manifests
    Dir["#{path}/**/manifests/*.pp"]
  end

  def templates
    Dir["#{path}/**/templates/*"]
  end

  def files
    Dir["#{path}/**/files/*"]
  end

  def self.configuration
    @configuration ||= PuppetGhostbuster::Configuration.new
  end

  def configuration
    self.class.configuration
  end

  def self.puppetdbserverfilename
    return configuration.puppetdbserverurl.gsub(/[:\/]/,'_')
  end

  def self.cache
    "/var/tmp/puppet-ghostbuster.#{puppetdbserverfilename}.cache"
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
    @@logger.debug "Connecting to puppet DB #{configuration.puppetdbserverurl}"
    PuppetDB::Client.new({
      :server => configuration.puppetdbserverurl,
      :pem    => {
        'key'     => configuration.hostprivkey,
        'cert'    => configuration.hostcert,
        'ca_file' => configuration.localcacert,
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
    @@logger.info 'Now trying to find unused classes'
    manifests.each do |file|
      @@logger.debug "  file #{file}."
      if File.symlink?(file)
        @@logger.warn "  Skipping symlink #{file}"
        next
      end
      if c = File.readlines(file).grep(/^class\s+([^\s\(\{]+)/){$1}[0]
        class_name = c.split('::').map(&:capitalize).join('::')
        count = self.class.used_classes.select { |klass| klass == class_name }.size
        puts "Class #{class_name} not used" if count == 0
      end
    end
  end

  def find_unused_defines
    @@logger.info 'Now trying to find unused defines'
    manifests.each do |file|
      if File.symlink?(file)
        @@logger.warn "  Skipping symlink #{file}"
        next
      end
      if d = File.readlines(file).grep(/^define\s+([^\s\(\{]+)/){$1}[0]
        define_name = d.split('::').map(&:capitalize).join('::')
        count = self.class.client.request('resources', [:'=', 'type', define_name]).data.size
        puts "Define #{define_name} not used" if count == 0
      end
    end
  end

  def find_unused_templates
    @@logger.info 'Now trying to find unused templates'
    templates.each do |template|
      next unless File.file?(template)
      module_name, template_name = template.match(/.*\/([^\/]+)\/templates\/(.+)$/).captures
      count = 0
      manifests.each do |manifest|
        if File.symlink?(manifest)
          @@logger.warn "  Skipping symlink #{manifest}"
          next
        end
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
    @@logger.info 'Now trying to find unused files'
    files.each do |file|
      next unless File.file?(file)
      module_name, file_name = file.match(/.*\/([^\/]+)\/files\/(.+)$/).captures
      count = 0
      Dir["#{path}"].each do |caller_file|
        next unless File.file?(caller_file)
        begin
          if caller_file =~ /\.pp$/
            if match = caller_file.match(/.*\/([^\/]+)\/manifests\/.+$/)
              manifest_module_name = match.captures[0]
              if manifest_module_name == module_name
                count += File.readlines(caller_file).grep(/["']\$\{module_name\}\/#{file_name}["']/).size
              end
            end
          end
          count += File.readlines(caller_file).grep(/#{module_name}\/#{file_name}/).size
        rescue ArgumentError
        end
      end
      puts "File #{file} not used" if count == 0
    end
  end

  def initialize(path = '.')
    self.path = path
    @@logger = Logger.new(STDERR).tap do |log|
      log.progname = 'PuppetGhostbuster'
      log.level=PuppetGhostbuster.configuration.loglevel
    end
  end

  def run
    find_unused_classes
    find_unused_defines
    find_unused_templates
    find_unused_files
  end

end

PuppetGhostbuster.configuration.defaults
