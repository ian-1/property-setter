# Stores repair details
class Repair
  attr_reader :title
  attr_reader :code

  def initialize(title, code)
    @title = title
    @code = code
  end
end
