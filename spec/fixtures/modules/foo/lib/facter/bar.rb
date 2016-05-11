# Fact used in manifest
Facter.add('bar') do
  setcode do
    'bar'
  end
end
