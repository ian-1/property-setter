require 'portfolio'

describe Portfolio do
  it '.how_many_properties' do
    expect(described_class).to respond_to(:how_many_properties)
  end
end
