# Stores property details
class Property
  attr_reader :address
  attr_reader :code
  attr_reader :repairs

  def initialize(address, code)
    @address = address
    @code = code
    @repairs = []
  end

  def add_repair(repair)
    @repairs << repair
  end

  # Not unit tested
  def save_line_generate
    save_line = "address<|>#{@address}<|-|>"
    save_line << "repairs<|>#{@repairs}<|-|>"
  end
end
