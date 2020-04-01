require 'repair'
require 'portfolio'

describe Repair do
  let(:repair) { described_class.new('test title', 172) }
  let(:property) { double :property }

  context '>new repair' do
    it '.new(title)' do
      expect(repair.title).to eq('test title')
      expect(repair.code).to eq(172)
    end

    it '#add_property' do
      portfolio = Portfolio.new
      property = portfolio.add_property
      repair.add_property(property)
      expect(repair.property).to be(property)
    end

    it '#is_active' do
      expect(repair.is_active).to eq(true)
    end
  end

  context '>closed repair' do
    before { repair.close_repair }

    it '#close_repair' do
      expect(repair.is_active).to eq(false)
    end
  end
end
