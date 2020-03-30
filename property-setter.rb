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

def menu_property
  puts "#{indent}Your options are:"
  puts ''
  puts "#{indent(7)}1) View properties"
  puts "#{indent(7)}2) Add property"
  puts "#{indent(7)}3) Remove Property"
  puts "#{indent(15)}(m -> maintenance menu)"
  puts "#{indent(15)}(q -> quit)"
  puts ''
  print "#{indent(3)}? "
end

def menu_property_respond(user_input, portfolio)
  case user_input
  when '1'
    view_properties(portfolio)
  when '2'
    add_property(portfolio)
  when '3'
    remove_property(portfolio)
  end
end

def menu_maintenance
  puts "#{indent}Your options are:"
  puts ''
  puts "#{indent(7)}1) View repair jobs"
  puts "#{indent(7)}2) Open repair job"
  puts "#{indent(7)}3) Add repair job"
  puts "#{indent(7)}4) Close repair job"
  puts "#{indent(7)}5) Remove repair job"
  puts "#{indent(15)}(p -> property menu)"
  puts "#{indent(15)}(q -> quit)"
  puts ''
  print "#{indent(3)}? "
end

def menu_maintenance_respond(user_input, maintenance, settings)
  case user_input
  when '1'
    view_repairs(maintenance)
  when '2'
    open_repair(maintenance, settings)
  when '3'
    add_repair(maintenance)
  when '4'
    close_repair(maintenance)
  when '5'
    remove_repair(maintenance)
  end
end

def repair_show(maintenance, settings)
  selected_repair = false
  maintenance.repairs.each do |repair|
    selected_repair = repair if repair.code == settings.selected_repair_code
  end
  if selected_repair == false
    puts "#{indent}Invalid Code (m -> back to maitenance menu)"
  end
  return if selected_repair == false

  puts"#{indent}Title: #{selected_repair.title}"
  unless selected_repair.is_active
    puts ''
    puts "#{indent(3)}THIS JOB IS NO LONGER ACTIVE"
  end
  puts ''
  puts "#{indent(15)}(m -> back to maitenance menu)"
  puts ''
  print "#{indent(3)}? "
end

def blank_space(message, width)
  blank_space_no = width - message.length
  blank_space = ''
  blank_space_no.times { blank_space << ' ' }
  blank_space
end

def indent(number_of_aditional_spaces = 0)
  number_of_spaces = 14 + number_of_aditional_spaces
  number_of_spaces.times { print ' ' }
  return
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
  print "#{indent(7)}"
  gets.chomp
end

def view_repairs_title(width)
  puts " | Code | Active | Job Title#{blank_space(' Job Title', width)}|"
  puts " |------|--------|#{dash_space(width)}|"
end

def view_repairs(maintenance)
  repairs = maintenance.repairs
  width = 25
  view_repairs_title(width)
  repairs.each do |repair|
    title = repair.title[0...width]
    code = "#{blank_space(repair.code.to_s, 5)}#{repair.code} "
    active = " #{repair.is_active.to_s}#{blank_space(repair.is_active.to_s, 7)}"
    puts " |#{code}|#{active}|#{title}#{blank_space(title, width)}|"
  end
  print "#{indent(7)}"
  gets.chomp
end

def add_property(portfolio)
  puts "#{indent}Enter address:     (c to cancel)"
  puts ''
  print "#{indent(3)}? "
  address = gets.chomp
  puts ''
  portfolio.add_property(address) if address != 'c'
end

def remove_property(portfolio)
  puts "#{indent}Enter code:     (c to cancel)"
  puts ''
  print "#{indent(3)}? "
  code = gets.chomp
  puts ''
  portfolio.remove_property(code) if code != 'c'
end

def open_repair(maintenance, settings)
  puts "#{indent}Enter code:     (c to cancel)"
  puts ''
  print "#{indent(3)}? "
  code = gets.chomp
  puts ''
  if code != 'c'
    settings.set_menu(:repair)
    settings.set_selected_repair_code(code)
  end
end

def add_repair(maintenance)
  puts "#{indent}Enter Job title:     (c to cancel)"
  puts ''
  print "#{indent(3)}? "
  title = gets.chomp
  puts ''
  maintenance.add_repair(title) if title != 'c'
end

def close_repair(maintenance)
  puts "#{indent}Enter code:     (c to cancel)"
  puts ''
  print "#{indent(3)}? "
  code = gets.chomp
  puts ''
  maintenance.close_repair(code) if code != 'c'
end

def remove_repair(maintenance)
  puts "#{indent}Enter code:     (c to cancel)"
  puts ''
  print "#{indent(3)}? "
  code = gets.chomp
  puts ''
  maintenance.remove_repair(code) if code != 'c'
end

portfolio = Portfolio.new
maintenance = Maintenance.new
settings = Settings.new(:property)
loop do
  system('clear')
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
  user_input = gets.chomp
  puts ''
  case settings.menu
  when :property
    menu_property_respond(user_input, portfolio)
  when :maintenance
    menu_maintenance_respond(user_input, maintenance, settings)
  end
  settings.set_menu(:maintenance) if user_input == 'm'
  settings.set_menu(:property) if user_input == 'p'
  break if user_input == 'q'
end
