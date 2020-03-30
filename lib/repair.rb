# Stores repair details
class Repair
  attr_reader :title
  attr_reader :code
  attr_reader :is_active

  def initialize(title, code)
    @title = title
    @code = code
    @is_active = true
  end

  def close_repair
    @is_active = false
  end
end
