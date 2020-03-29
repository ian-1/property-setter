require 'portfolio'

describe Portfolio do
  it '.how_many_properties' do
    expect(described_class).to respond_to(:how_many_properties)
  end

  it '.add_property' do
    expect(described_class).to respond_to(:add_property)
  end

  it '.remove_property' do
    expect(described_class).to respond_to(:remove_property)
  end
end
