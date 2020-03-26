require 'property'

describe Property do
  it 'add new property' do
    expect(described_class).to respond_to(:new)
  end
end
