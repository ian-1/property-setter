# settings for temporary interface, has not been unit tested
class Settings
  attr_reader :menu
  attr_reader :selected_repair_code

  def initialize(menu)
    @menu = menu
    @selected_repair_code = 0
  end

  def change_menu(menu)
    @menu = menu
  end

  def change_selected_repair_code(code)
    @selected_repair_code = code.to_i
  end

  def reset_selected_repair_code
    @selected_repair_code = 0
  end
end
