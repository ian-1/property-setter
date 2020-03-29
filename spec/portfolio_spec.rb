require 'portfolio'

describe Portfolio do
  let(:portfolio) { described_class.new }

  context 'empty portfolio' do
    it '#add_property' do
      portfolio.add_property
      expect(portfolio.how_many_properties).to eq(1)
    end

    it '#remove_property' do
      portfolio.remove_property
      expect(portfolio.how_many_properties).to eq(-1)
    end

    it '#add_property(address)' do
      portfolio.add_property('test address')
      expect(portfolio.properties[-1]).to be_instance_of(Property)
    end

    it '#add_property(address)' do
      portfolio.add_property('test address')
      expect(portfolio.properties[-1].address).to eq('test address')
    end
  end

  context '1 property in portfolio' do
    before { portfolio.add_property }

    it '#add_property' do
      portfolio.add_property
      expect(portfolio.how_many_properties).to eq(2)
    end

    it '#remove_property' do
      portfolio.remove_property
      expect(portfolio.how_many_properties).to eq(0)
    end

    it '#add_property(address)' do
      portfolio.add_property('test address')
      expect(portfolio.properties[-1].address).to eq('test address')
    end
  end

  context 'many properties in portfolio' do
    many_properties = 50_000
    before { many_properties.times { portfolio.add_property } }

    it '#add_property' do
      portfolio.add_property
      expect(portfolio.how_many_properties).to eq(many_properties + 1)
    end

    it '#remove_property' do
      portfolio.remove_property
      expect(portfolio.how_many_properties).to eq(many_properties - 1)
    end

    it '#add_property(address)' do
      portfolio.add_property('test address')
      expect(portfolio.properties[-1].address).to eq('test address')
    end
  end
end
