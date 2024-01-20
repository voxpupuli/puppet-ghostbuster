# frozen_string_literal: true

# Fact is a symbol
Facter.add(:asym) do
  setcode do
    'asym'
  end
end
