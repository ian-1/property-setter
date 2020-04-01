require './lib/property.rb'

# Stores properties
class Portfolio
  attr_reader :properties

  def initialize
    @properties = []
    @property_code = 100
  end

  def how_many_properties
    @properties.count
  end

  def property_from_code(property_code)
    correct_property = nil
    @properties.map do |property|
      correct_property = property if property.code == property_code.to_i
    end
    correct_property
  end

  def add_property(address = '-empty')
    @property_code += 1
    @properties << Property.new(address, @property_code)
  end

  def remove_property(property_code)
    @properties.reject! { |property| property.code == property_code.to_i }
  end

  # Not unit tested
  def save_properties
    open('properties.txt', 'w') do |file|
      @properties.each do |property|
        save_line = property.save_line_generate
        file.puts save_line[0...-5]
      end
    end
  end

  # Not unit tested
  def load_each_property(line, _code)
    entries = line.chomp.split('<|-|>')
    entries.each do |entry|
      task, value = entry.chomp.split('<|>')
      add_property(value) if task == 'address'
    end
  end

  # Not unit tested
  def load_properties
    open('properties.txt', 'r') do |file|
      code = 100
      file.readlines.each do |line|
        code += 1
        load_each_property(line, code)
      end
    end
  end
end
