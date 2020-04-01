require 'maintenance'

describe Maintenance do
  let(:maintenance) { described_class.new }
  let(:repair) { Repair.new('Test_Title', 101) }
  let(:property) { Property.new('Test_Address', 101) }

  context '>empty maintenance' do
    it '#add_repair' do
      maintenance.add_repair('test title')
      expect(maintenance.how_many_repairs).to eq(1)
      expect(maintenance.how_many_active_repairs).to eq(1)
      expect(maintenance.repairs[-1]).to be_instance_of(Repair)
      expect(maintenance.repairs[-1].title).to eq('test title')
      expect(maintenance.repairs[-1].code).to eq(101)
    end

    it '#remove_repair' do
      maintenance.remove_repair(1)
      expect(maintenance.how_many_repairs).to eq(0)
      expect(maintenance.how_many_active_repairs).to eq(0)
    end
  end

  context '>1 repair in maintenance' do
    before { maintenance.add_repair }

    it '#add_repair' do
      maintenance.add_repair('test title')
      expect(maintenance.how_many_repairs).to eq(2)
      expect(maintenance.how_many_active_repairs).to eq(2)
      expect(maintenance.repairs[-1]).to be_instance_of(Repair)
      expect(maintenance.repairs[-1].title).to eq('test title')
      expect(maintenance.repairs[-1].code).to eq(102)
    end

    context '>valid repair_code' do
      it '#remove_repair' do
        maintenance.remove_repair(101)
        expect(maintenance.how_many_repairs).to eq(0)
        expect(maintenance.how_many_active_repairs).to eq(0)
      end

      it '#close_repair' do
        maintenance.close_repair(101)
        expect(maintenance.how_many_repairs).to eq(1)
        expect(maintenance.how_many_active_repairs).to eq(0)
      end
    end

    context '>non-valid repair_code' do
      it '#remove_repair' do
        maintenance.remove_repair(732)
        expect(maintenance.how_many_repairs).to eq(1)
        expect(maintenance.how_many_active_repairs).to eq(1)
      end

      it '#close_repair' do
        maintenance.close_repair(237)
        expect(maintenance.how_many_repairs).to eq(1)
        expect(maintenance.how_many_active_repairs).to eq(1)
      end
    end
  end

  context '>many repairs in maintenance' do
    many_repairs = 100_000 # Must be > 100 for later remove test to work
    before { many_repairs.times { maintenance.add_repair } }

    it '#add_repair' do
      maintenance.add_repair('test title')
      expect(maintenance.how_many_repairs).to eq(many_repairs + 1)
      expect(maintenance.how_many_active_repairs).to eq(many_repairs + 1)
      expect(maintenance.repairs[-1]).to be_instance_of(Repair)
      expect(maintenance.repairs[-1].title).to eq('test title')
      expect(maintenance.repairs[-1].code).to eq(many_repairs + 101)
    end

    context '>valid repair_code' do
      it '#remove_repair' do
        maintenance.remove_repair(many_repairs - 100)
        expect(maintenance.how_many_repairs).to eq(many_repairs - 1)
        expect(maintenance.how_many_active_repairs).to eq(many_repairs - 1)
      end

      it '#close_repair' do
        maintenance.close_repair(many_repairs - 76)
        expect(maintenance.how_many_repairs).to eq(many_repairs)
        expect(maintenance.how_many_active_repairs).to eq(many_repairs - 1)
      end

      it '#repair_from_code' do
        repair = maintenance.repair_from_code(many_repairs)
        expect(repair).to be_instance_of(Repair)
        expect(repair.code).to eq(many_repairs)
      end

      it '#link_repair_to_property(repair, property)' do
        maintenance.link_repair_to_property(repair, property)
        expect(repair.property).to eq(property)
        expect(property.repairs[-1]).to eq(repair)
      end
    end

    context '>non-valid repair_code' do
      it '#remove_repair' do
        maintenance.remove_repair(many_repairs + 101)
        expect(maintenance.how_many_repairs).to eq(many_repairs)
        expect(maintenance.how_many_active_repairs).to eq(many_repairs)
      end

      it '#close_repair' do
        maintenance.close_repair(many_repairs + 101)
        expect(maintenance.how_many_repairs).to eq(many_repairs)
        expect(maintenance.how_many_active_repairs).to eq(many_repairs)
      end

      it '#repair_from_code' do
        repair = maintenance.repair_from_code(many_repairs + 101)
        expect(repair).to eq(nil)
      end
    end
  end
end
