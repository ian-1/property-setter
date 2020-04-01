require 'portfolio'

describe Portfolio do
  let(:portfolio) { described_class.new }

  context '>empty portfolio' do
    it '#add_property' do
      portfolio.add_property('test address')
      expect(portfolio.how_many_properties).to eq(1)
      expect(portfolio.properties[-1]).to be_instance_of(Property)
      expect(portfolio.properties[-1].address).to eq('test address')
      expect(portfolio.properties[-1].code).to eq(101)
    end

    it '#remove_property' do
      portfolio.remove_property(101)
      expect(portfolio.how_many_properties).to eq(0)
    end
  end

  context '>1 property in portfolio' do
    before { portfolio.add_property }

    it '#add_property' do
      portfolio.add_property('test address')
      expect(portfolio.how_many_properties).to eq(2)
      expect(portfolio.properties[-1]).to be_instance_of(Property)
      expect(portfolio.properties[-1].address).to eq('test address')
      expect(portfolio.properties[-1].code).to eq(102)
    end

    context '>valid property_code' do
      it '#remove_property' do
        portfolio.remove_property(101)
        expect(portfolio.how_many_properties).to eq(0)
      end
    end

    context '>non-valid property_code' do
      it '#remove_property' do
        portfolio.remove_property(732)
        expect(portfolio.how_many_properties).to eq(1)
      end
    end
  end

  context '>many properties in portfolio' do
    many_properties = 5_000 # Must be > 100 for later remove test to work
    before { many_properties.times { portfolio.add_property } }

    it '#add_property' do
      portfolio.add_property('test address')
      expect(portfolio.how_many_properties).to eq(many_properties + 1)
      expect(portfolio.properties[-1]).to be_instance_of(Property)
      expect(portfolio.properties[-1].address).to eq('test address')
      expect(portfolio.properties[-1].code).to eq(many_properties + 101)
    end

    context '>valid property_code' do
      it '#remove_property' do
        portfolio.remove_property(many_properties)
        expect(portfolio.how_many_properties).to eq(many_properties - 1)
      end

      it '#property_from_code' do
        property = portfolio.property_from_code(many_properties)
        expect(property).to be_instance_of(Property)
        expect(property.code).to eq(many_properties)
      end
    end

    context '>non-valid property_code' do
      it '#remove_property' do
        portfolio.remove_property(many_properties + 101)
        expect(portfolio.how_many_properties).to eq(many_properties)
      end

      it '#property_from_code' do
        property = portfolio.property_from_code(many_properties + 101)
        expect(property).to eq(nil)
      end
    end
  end
end
