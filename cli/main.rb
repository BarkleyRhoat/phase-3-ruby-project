#!/usr/bin/env ruby

require "readline"
require_relative "../config/environment"
require_relative "player_manager"
require_relative "course_manager"
require_relative "round_manager"

class Menu
  def run
    puts "Welcome to Golf Score Tracker!"
    puts

    loop do
      display_menu

      choice = Readline.readline("Choose an option: ", true).chomp

      case choice
      when "1"
        PlayerManager.new.run
      when "2"
        CourseManager.new.run
      when "3"
        RoundManager.new.run
      when "4"
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
    puts "3. Round Management"
    puts "4. Exit"
    puts
  end
end

Menu.new.run
