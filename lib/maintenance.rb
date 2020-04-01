require './lib/repair.rb'

# Stores repairs
class Maintenance
  attr_reader :repairs

  def initialize
    @repairs = []
    @repair_code = 100
  end

  def how_many_repairs
    @repairs.count
  end

  def how_many_active_repairs
    active_repairs = 0
    @repairs.each do |repair|
      active_repairs += 1 if repair.is_active
    end
    active_repairs
  end

  def add_repair(title = '-empty')
    @repair_code += 1
    @repairs << Repair.new(title, @repair_code)
  end

  def remove_repair(repair_code)
    @repairs.reject! { |repair| repair.code == repair_code.to_i }
  end

  def close_repair(repair_code)
    @repairs.each do |repair|
      repair.close_repair if repair.code == repair_code.to_i
    end
  end

  # Not unit tested
  def save_repairs
    open('repairs.txt', 'w') do |file|
      @repairs.each do |repair|
        save_line = repair.save_line_generate
        file.puts save_line[0...-5]
      end
    end
  end

  # Not unit tested
  def load_each_repair(line, code)
    entries = line.chomp.split('<|-|>')
    entries.each do |entry|
      task, value = entry.chomp.split('<|>')
      add_repair(value) if task == 'title'
      close_repair(code) if task == 'is_active' && value == 'false'
    end
  end

  # Not unit tested
  def load_repairs
    open('repairs.txt', 'r') do |file|
      code = 0
      file.readlines.each do |line|
        code += 1
        load_each_repair(line, code)
      end
    end
  end
end
