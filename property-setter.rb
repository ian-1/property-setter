#!/usr/bin/env ruby
# Temporary menu driven interface for property-setter, has not been unit tested
require './lib/portfolio.rb'
require './lib/maintenance.rb'
require './lib/settings.rb'

def title_print
  puts "#{indent}#######################################"
  puts "#{indent}#                                     #"
  puts "#{indent}#           PROPERTY SETTER           #"
  puts "#{indent}#                                     #"
  puts "#{indent}#######################################"
  puts ''
end

def sub_title_print(settings, portfolio, maintenance)
  case settings.menu
  when :property
    property_no_print(portfolio)
  when :maintenance
    maintenance_no_print(maintenance)
  end
end

def property_no_print(portfolio)
  puts "#{indent}Properties: #{portfolio.how_many_properties}"
end

def maintenance_no_print(maintenance)
  puts "#{indent}Total Repairs:  #{maintenance.how_many_repairs}"
  puts "#{indent}Active Repairs: #{maintenance.how_many_active_repairs}"
end

def menu_intro
  puts "#{indent}Your options are:"
  puts ''
end

def input_prompt
  puts ''
  print "#{indent(3)}? "
end

def input_from_user
  user_input = gets.chomp
  puts ''
  user_input
end

def enter_info(info_name)
  puts "#{indent}Enter #{info_name}:     (c to cancel)"
  input_prompt
  input_from_user
end

def menu_property
  menu_intro
  puts "#{indent(7)}1) View properties"
  puts "#{indent(7)}2) Add property"
  puts "#{indent(7)}3) Remove Property"
  puts "#{indent(15)}(m -> maintenance menu)"
  puts "#{indent(15)}(q -> quit)"
  input_prompt
end

def menu_property_respond(user_input, portfolio)
  view_properties(portfolio) if user_input == '1'
  add_property(portfolio) if user_input == '2'
  remove_property(portfolio) if user_input == '3'
end

def menu_maintenance
  menu_intro
  space = indent(7)
  puts "#{space}1) View repair jobs"
  puts "#{space}2) Open repair job"
  puts "#{space}3) Add repair job"
  puts "#{space}4) Close repair job"
  puts "#{space}5) Remove repair job"
  puts "#{indent(15)}(p -> property menu)"
  puts "#{indent(15)}(q -> quit)"
  input_prompt
end

def menu_maintenance_respond(user_input, maintenance, settings)
  view_repairs(maintenance, settings) if user_input == '1'
  open_repair(settings) if user_input == '2'
  add_repair(maintenance) if user_input == '3'
  close_repair(maintenance) if user_input == '4'
  remove_repair(maintenance) if user_input == '5'
end

def repair_show_title(title)
  puts "#{indent}Title: #{title[0..31]}"
  title = title[32..-1]
  until title.nil?
    title = title[1..-1] if title[0] == ' '
    puts "#{indent(7)}#{title[0..31]}"
    title = title[32..-1]
  end
end

def repair_show_display(selected_repair)
  repair_show_title(selected_repair.title)
  unless selected_repair.is_active
    puts ''
    puts "#{indent(3)}THIS JOB IS NO LONGER ACTIVE"
  end
  puts ''
  puts "#{indent(9)}(m -> back to maitenance menu)"
  input_prompt
end

def repair_show(maintenance, settings)
  selected_repair = false
  maintenance.repairs.each do |repair|
    selected_repair = repair if repair.code == settings.selected_repair_code
  end
  if selected_repair == false
    puts "#{indent}Invalid Code (m -> back to maitenance menu)"
  end
  repair_show_display(selected_repair) unless selected_repair == false
end

def blank_space(message, width)
  blank_space_no = width - message.length
  blank_space = ''
  blank_space_no.times { blank_space << ' ' }
  blank_space
end

def indent(number_of_aditional_spaces = 0)
  number_of_spaces = 14 + number_of_aditional_spaces
  spaces = ''
  (number_of_spaces - 1).times { spaces << ' ' }
  spaces
end

def dash_space(width)
  dashes = ''
  width.times { dashes << '-' }
  dashes
end

def view_properties_title(width)
  puts " | Code | Address#{blank_space(' Address', width)}|"
  puts " |------|#{dash_space(width)}|"
end

def view_properties(portfolio)
  properties = portfolio.properties
  width = 45
  view_properties_title(width)
  properties.each do |property|
    address = property.address[0...width]
    puts " |  #{property.code} |#{address}#{blank_space(address, width)}|"
  end
  input_prompt
  user_input = input_from_user
  menu_property_respond(user_input, portfolio)
end

def view_repairs_title(width)
  puts " | Code | Active | Job Title#{blank_space(' Job Title', width)}|"
  puts " |------|--------|#{dash_space(width)}|"
end

def view_repairs_fill(repairs, width)
  repairs.each do |repair|
    title = repair.title[0...width]
    code = "#{blank_space(repair.code.to_s, 5)}#{repair.code} "
    active = " #{repair.is_active}#{blank_space(repair.is_active.to_s, 7)}"
    puts " |#{code}|#{active}|#{title}#{blank_space(title, width)}|"
  end
end

def view_repairs(maintenance, settings)
  width = 40
  view_repairs_title(width)
  view_repairs_fill(maintenance.repairs, width)
  input_prompt
  user_input = input_from_user
  menu_maintenance_respond(user_input, maintenance, settings)
end

def add_property(portfolio)
  address = enter_info('address')
  portfolio.add_property(address) unless address == 'c'
end

def remove_property(portfolio)
  code = enter_info('code')
  portfolio.remove_property(code) unless code == 'c'
end

def open_repair(settings)
  code = enter_info('code')
  settings.change_menu(:repair) unless code == 'c'
  settings.change_selected_repair_code(code)
end

def add_repair(maintenance)
  title = enter_info('Job title')
  maintenance.add_repair(title) unless title == 'c'
end

def close_repair(maintenance)
  code = enter_info('code')
  maintenance.close_repair(code) unless code == 'c'
end

def remove_repair(maintenance)
  code = enter_info('code')
  maintenance.remove_repair(code) unless code == 'c'
end

portfolio = Portfolio.new
portfolio.load_properties
maintenance = Maintenance.new
maintenance.load_repairs
settings = Settings.new(:property)
loop do
  system('clear')
  system('cls')
  settings.reset_selected_repair_code unless settings.menu == :repair
  title_print
  sub_title_print(settings, portfolio, maintenance)
  puts ''
  case settings.menu
  when :property
    menu_property
  when :maintenance
    menu_maintenance
  when :repair
    repair_show(maintenance, settings)
  end
  user_input = input_from_user
  case settings.menu
  when :property
    menu_property_respond(user_input, portfolio)
  when :maintenance
    menu_maintenance_respond(user_input, maintenance, settings)
  end
  settings.change_menu(:maintenance) if user_input == 'm'
  settings.change_menu(:property) if user_input == 'p'
  break if user_input == 'q'
end
portfolio.save_properties
maintenance.save_repairs
