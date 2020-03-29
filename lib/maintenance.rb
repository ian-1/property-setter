require './lib/repair.rb'

# Stores repairs
class Maintenance
  attr_reader :repairs

  def initialize
    @repairs = []
    @repair_code = 0
  end

  def how_many_repairs
    @repairs.count
  end

  def add_repair(title = '-empty')
    @repair_code += 1
    @repairs << Repair.new(title, @repair_code)
  end

  def remove_repair(repair_code)
    @repairs.reject! { |repair| repair.code == repair_code.to_i }
  end
end
