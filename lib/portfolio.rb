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

  def add_property(address = '-empty')
    @property_code += 1
    @properties << Property.new(address, @property_code)
  end

  def remove_property(property_code)
    @properties.reject! { |property| property.code == property_code }
  end
end
