# Fact used in a string
Facter.add('foo') do
  setcode do
    'foo'
  end
end
