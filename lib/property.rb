# Stores property details
class Property
  attr_reader :address
  attr_reader :code

  def initialize(address, code)
    @address = address
    @code = code
  end
end
