# Stores properties
class Portfolio
  attr_reader :properties

  def initialize
    @properties = []
    @no_of_properties = 0
  end

  def how_many_properties
    @no_of_properties
  end

  def add_property(address = '-empty')
    @no_of_properties += 1
    @properties << Property.new(address)
  end

  def remove_property
    @no_of_properties -= 1
  end
end
