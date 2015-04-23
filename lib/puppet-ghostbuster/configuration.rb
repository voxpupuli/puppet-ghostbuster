class PuppetGhostbuster
  # Public: A singleton class to store the running configuration of
  # puppet-ghostbuster.
  class Configuration

    def initialize
      Puppet.initialize_settings
    end

    # Public: Catch situations where options are being set for the first time
    # and create the necessary methods to get & set the option in the future.
    #
    # args   - An Array of values to set the option to.
    # method - The String name of the option.
    # block  - Unused.
    #
    # Returns nothing.
    #
    # Signature
    #
    #   <option>=(value)
    def method_missing(method, *args, &block)
      if method.to_s =~ /^(\w+)=$/
        option = $1
        add_option(option.to_s) if settings[option].nil?
        settings[option] = args[0]
      else
        nil
      end
    end

    # Internal: Add options to the PuppetGhostbuster::Configuration object from inside
    # the class.
    #
    # option - The String name of the option.
    #
    # Returns nothing.
    #
    # Signature
    #
    #   <option>
    #   <option>=(value)
    def add_option(option)
      self.class.add_option(option)
    end

    # Public: Add an option to the PuppetGhostbuster::Configuration object from
    # outside the class.
    #
    # option - The String name of the option.
    #
    # Returns nothing.
    #
    # Signature
    #
    #   <option>
    #   <option>=(value)
    def self.add_option(option)
      # Public: Set the value of the named option.
      #
      # value - The value to set the option to.
      #
      # Returns nothing.
      define_method("#{option}=") do |value|
        settings[option] = value
      end

      # Public: Get the value of the named option.
      #
      # Returns the value of the option.
      define_method(option) do
        settings[option]
      end
    end

    # Internal: Access the internal storage for settings.
    #
    # Returns a Hash containing all the settings.
    def settings
      @settings ||= {}
    end

    # Public: Clear the PuppetGhostbuster::Configuration storage and set some sane
    # default values.
    #
    # Returns nothing.
    def defaults
      settings.clear
      self.loglevel = Logger::INFO
      self.puppetdbserverurl = "https://#{Puppet[:server]}:8081"
      self.hostprivkey = Puppet[:hostprivkey]
      self.hostcert    = Puppet[:hostcert]
      self.localcacert = Puppet[:localcacert]
    end
  end
end
