#!/usr/bin/env ruby

require_relative "../config/environment"
require_relative "player_manager"
require_relative "course_manager"

class Menu
  def run
    puts "Welcome to Golf Score Tracker!"
    puts

    loop do
      display_menu

      print "Choose an option: "
      choice = gets.chomp

      case choice
      when "1"
        PlayerManager.new.run
      when "2"
        CourseManager.new.run
      when "3"
        puts "Goodbye!"
        break
      else
        puts "Invalid option. Please try again."
      end

      puts
    end
  end

  private

  def display_menu
    puts "== Main Menu =="
    puts "1. Player Management"
    puts "2. Course Management"
    puts "3. Exit"
    puts
  end
end

Menu.new.run
