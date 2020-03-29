#!/usr/bin/env ruby
# Temporary menu driven interface for property-setter, has not been unit tested
require './lib/portfolio.rb'
require './lib/maintenance.rb'

def title_print
  puts '              #######################################'
  puts '              #                                     #'
  puts '              #           PROPERTY SETTER           #'
  puts '              #                                     #'
  puts '              #######################################'
  puts ''
end

def sub_title_print(menu, portfolio, maintenance)
  case menu
  when :property
    property_no_print(portfolio.how_many_properties)
  when :repair
    repair_no_print(maintenance.how_many_repairs)
  end
end

def property_no_print(total_no_of_properties)
  print "              Properties: #{total_no_of_properties}"
end

def repair_no_print(total_no_of_repairs)
  print "              Repairs: #{total_no_of_repairs}"
end

def menu_property
  puts '              Your options are:'
  puts ''
  puts '                     1) View properties'
  puts '                     2) Add property'
  puts '                     3) Remove Property'
  puts '                             (m -> maintenance menu)'
  puts '                             (q -> quit)'
  puts ''
  print '                  ? '
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

def menu_repair
  puts '              Your options are:'
  puts ''
  puts '                     1) View repair jobs'
  puts '                     2) Add repair job'
  puts '                     3) Remove repair job'
  puts '                             (p -> property menu)'
  puts '                             (q -> quit)'
  puts ''
  print '                  ? '
end

def menu_repair_respond(user_input, maintenance)
  case user_input
  when '1'
    view_repairs(maintenance)
  when '2'
    add_repair(maintenance)
  when '3'
    remove_repair(maintenance)
  end
end

def blank_space(message, width)
  blank_space_no = width - message.length
  blank_space = ''
  blank_space_no.times { blank_space << ' ' }
  blank_space
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
  print '                    '
  gets.chomp
end

def view_repairs_title(width)
  puts " | Code | Job Title#{blank_space(' Job Title', width)}|"
  puts " |------|#{dash_space(width)}|"
end

def view_repairs(maintenance)
  repairs = maintenance.repairs
  width = 25
  view_repairs_title(width)
  repairs.each do |repair|
    title = repair.title[0...width]
    code = "#{blank_space(repair.code.to_s, 5)}#{repair.code} "
    puts " |#{code}|#{title}#{blank_space(title, width)}|"
  end
  print '                    '
  gets.chomp
end

def add_property(portfolio)
  puts '              Enter address:     (q to go back)'
  puts ''
  print '                  ? '
  address = gets.chomp
  puts ''
  portfolio.add_property(address) if address != 'q'
end

def remove_property(portfolio)
  puts '              Enter code:     (q to go back)'
  puts ''
  print '                  ? '
  code = gets.chomp
  puts ''
  portfolio.remove_property(code) if code != 'q'
end

def add_repair(maintenance)
  puts '              Enter Job title:     (q to go back)'
  puts ''
  print '                  ? '
  title = gets.chomp
  puts ''
  maintenance.add_repair(title) if title != 'q'
end

def remove_repair(maintenance)
  puts '              Enter code:     (q to go back)'
  puts ''
  print '                  ? '
  code = gets.chomp
  puts ''
  maintenance.remove_repair(code) if code != 'q'
end

portfolio = Portfolio.new
maintenance = Maintenance.new
menu = :property
loop do
  system('clear')
  title_print
  sub_title_print(menu, portfolio, maintenance)
  2.times { puts '' }
  case menu
  when :property
    menu_property
  when :repair
    menu_repair
  end
  user_input = gets.chomp
  puts ''
  case menu
  when :property
    menu_property_respond(user_input, portfolio)
  when :repair
    menu_repair_respond(user_input, maintenance)
  end
  menu = :repair if user_input == 'm'
  menu = :property if user_input == 'p'
  break if user_input == 'q'
end
