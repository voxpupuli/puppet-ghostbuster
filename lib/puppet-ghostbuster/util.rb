class PuppetGhostbuster
  class Util
    class << self
      def search_file(name, search)
        return search_file_regexp(name, search) if search.is_a?(Regexp)

        File.foreach(name) do |line|
          return true if line.include?(search)
        end
      end

      def search_file_regexp(name, search)
        File.foreach(name) do |line|
          return true if line.match?(search)
        end
      end
    end
  end
end
