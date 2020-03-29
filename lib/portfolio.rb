# Stores properties
class Portfolio
  attr_reader :properties

  def initialize
    @properties = []
  end

  def how_many_properties
    @properties.count
  end

  def add_property(address = '-empty')
    @properties << Property.new(address)
  end

  def remove_property
    @properties.pop
  end
end
