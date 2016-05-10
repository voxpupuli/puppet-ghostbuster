require 'puppet-ghostbuster'

PuppetLint.new_check(:ghostbuster_classes) do
  def check
    return if path.match(%r{.*/([^/]+)/manifests/(.+)$}).nil?

    class_indexes.each do |class_idx|
      title_token = class_idx[:name_token]
      title = title_token.value.split('::').map(&:capitalize).join('::')

      return if classes.include? title

      notify :warning, {
        :message => "Class #{title} seems unused",
        :line    => title_token.line,
        :column  => title_token.column,
      }
    end
  end
end
