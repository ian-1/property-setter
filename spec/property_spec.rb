require 'property'

describe Property do
  it '.new(address)' do
    expect(described_class.new('test address').address).to eq('test address') 
  end
end
