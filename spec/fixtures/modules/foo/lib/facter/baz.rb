# frozen_string_literal: true

# Fact used in template
Facter.add('baz') do
  setcode do
    'baz'
  end
end
