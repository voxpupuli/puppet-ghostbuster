# frozen_string_literal: true

# Fact used in inline_template
Facter.add('quux') do
  setcode do
    'quux'
  end
end
