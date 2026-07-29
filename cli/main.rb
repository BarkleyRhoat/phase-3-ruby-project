#!/usr/bin/env ruby

require "readline"
require "colorize"
require "tty-font"
require_relative "../config/environment"
require_relative "player_manager"
require_relative "course_manager"
require_relative "round_manager"

class Menu
  def run
    font = TTY::Font.new(:doom)
    puts font.write("Welcome").red
    puts <<~ART
         '                   .  .
           \\              .         ' .             |>6>> 
          O>>         .                 'o           |
           \\       .                                |
           /\\    .                                  |
          / /  .'                                    |
        ^^^^^^^`^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    ART
    puts

    loop do
      display_menu

      choice = Readline.readline("Choose an option: ".red, true).chomp

      case choice
      when "1"
        PlayerManager.new.run
      when "2"
        CourseManager.new.run
      when "3"
        RoundManager.new.run
      when "4"
        puts font.write("Goodbye!").red
        break
      else
        puts "Invalid option. Please try again."
      end

      puts
    end
  end

  private

  def display_menu
    puts "\n==============================".green
    puts "      Golf Score Tracker        ".red.bold
    puts "==============================".green
    puts "1. Player Management 🏌️"
    puts "2. Course Management ⛳"
    puts "3. Round Management  🚩"
    puts "4. Exit"
    puts "==============================\n".green
  end
end

Menu.new.run
