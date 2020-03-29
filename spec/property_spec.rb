require 'property'

describe Property do
  let(:property) { described_class.new('test address', 172) }

  it '.new(address)' do
    expect(property.address).to eq('test address')
    expect(property.code).to eq(172)
  end
end
