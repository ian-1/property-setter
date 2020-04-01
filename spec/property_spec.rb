require 'property'

describe Property do
  let(:property) { described_class.new('test address', 172) }
  let(:repair) { double :repair }
  let(:repair2) { double :repair2 }

  it '.new(address)' do
    expect(property.address).to eq('test address')
    expect(property.code).to eq(172)
  end

  it '#add_repair' do
    many = 72
    property.add_repair(repair)
    many.times { property.add_repair(repair2) }
    property.add_repair(repair)
    many.times { property.add_repair(repair2) }
    expect(property.repairs[-1]).not_to be(repair)
    expect(property.repairs[-(many + 1)]).to be(repair)
    expect(property.repairs[0]).to be(repair)
  end
end
