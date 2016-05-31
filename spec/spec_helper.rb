require 'puppet-lint'
require 'jgrep'

PuppetLint::Plugins.load_spec_helper

class PuppetDB::Client
  def puppetdb_to_jgrep(query)
    if query[0] == :'and' || query[0] == :'or'
      "(#{puppetdb_to_jgrep(query[1])} #{query[0]} #{puppetdb_to_jgrep(query[2])})"
    else
      "#{[query[1]].flatten.join('.')}#{query[0]}#{query[2]}"
    end
  end

  def request(endpoint, query, opts={})
    jquery = puppetdb_to_jgrep(query)
    ret = JGrep.jgrep(File.read("spec/fixtures/#{endpoint}.json"), jquery)
    PuppetDB::Response.new(ret, ret.size)
  end
end

