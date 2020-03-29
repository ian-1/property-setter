require 'repair'

describe Repair do
  let(:repair) { described_class.new('test title', 172) }

  it '.new(title)' do
    expect(repair.title).to eq('test title')
    expect(repair.code).to eq(172)
  end
end
