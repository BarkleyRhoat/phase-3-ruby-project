#!/usr/bin/env ruby

require "readline"
require "colorize"
require "tty-font"
require_relative "../config/environment"
require_relative "player_manager"
require_relative "course_manager"
require_relative "round_manager"
require_relative "color_helper"

class Menu
  include ColorHelper

  def run
    font = TTY::Font.new(:doom)
    puts header_title(font.write("Welcome"))
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

      choice = Readline.readline(prompt("Choose an option: "), true).chomp

      case choice
      when "1"
        PlayerManager.new.run
      when "2"
        CourseManager.new.run
      when "3"
        RoundManager.new.run
      when "4"
        puts header_title(font.write("Goodbye!"))
        break
      else
        puts error("Invalid option. Please try again.")
      end

      puts
    end
  end

  private

  def display_menu
    puts header_border("\n==============================")
    puts header_title("      Golf Score Tracker        ")
    puts header_border("==============================")
    puts "1. Player Management 🏌️"
    puts "2. Course Management ⛳"
    puts "3. Round Management  🚩"
    puts "4. Exit"
    puts header_border("==============================\n")
  end
end

Menu.new.run
