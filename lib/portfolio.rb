# Stores properties
class Portfolio
  def initialize
    @no_of_properties = 0
  end

  def how_many_properties
    @no_of_properties
  end

  def add_property
    @no_of_properties += 1
  end

  def remove_property
    @no_of_properties -= 1
  end
end
