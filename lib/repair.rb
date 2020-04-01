#require 'portfolio'

# Stores repair details
class Repair
  attr_reader :title
  attr_reader :code
  attr_reader :is_active
  attr_reader :property

  def initialize(title, code)
    @title = title
    @code = code
    @is_active = true
    @property = nil
  end

  def close_repair
    @is_active = false
  end

  def add_property(portfolio, property_code)
    property = portfolio.property_from_code(property_code)
    @property = property
    property.add_repair(self)
  end

  # Not unit tested
  def save_line_generate
    save_line = "title<|>#{@title}<|-|>"
    save_line << "is_active<|>#{@is_active}<|-|>"
  end
end
