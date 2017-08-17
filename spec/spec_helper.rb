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

  def process_pql_kv(q)
      k, v = q.split(/\s*=\s*/)
      ".#{k}=#{v}"
  end

  def pql_to_jgrep(query)
      endpoint_cols = query.split('{').first
      endpoint = endpoint_cols.split(/[\s\[]/).first
      query.sub!(/^#{Regexp.quote(endpoint_cols)}\{\s*/, '')
      query.sub!(/\s*}\s*/, '')
      query.sub!(/(and\s+)?nodes\s*\{\s*deactivated\s+is\s+not\s+null\s*\}/, '')

      return endpoint, '' if query == ''

      query.gsub!('parameters.', 'parameter.')
      query.sub!(/\s*=\s*/, '=')

      jgrep_query_and_parts = []
      query.split(/\s+and\s+/).each do |q|
          newq = ''
          if q.start_with?('(')
              newq << '('
              newq << q.split(/\s+or\s+/).map do |qq|
                  process_pql_kv(qq.sub(/^\(/, '').sub(/\)$/, ''))
              end.join(' or ')
              newq << ')'
          else
              newq << process_pql_kv(q)
          end
          jgrep_query_and_parts << newq
      end
      jgrep_query = jgrep_query_and_parts.join(" and ")

      return endpoint, jgrep_query
  end

  def request(endpoint, query, opts={})
    if endpoint == ''
        endpoint, query = pql_to_jgrep(query)
    else
        query = puppetdb_to_jgrep(query)
    end
    ret = JGrep.jgrep(File.read("spec/fixtures/#{endpoint}.json"), query)
    PuppetDB::Response.new(ret, ret.size)
  end
end

