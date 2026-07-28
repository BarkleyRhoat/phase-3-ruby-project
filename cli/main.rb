#!/usr/bin/env ruby

require_relative "../config/environment"
require_relative "player_manager"
class Menu
  def initialize
    @player_manager = PlayerManager.new
  end

  def run
    puts "Welcome to Golf Score Tracker!"
    puts

    loop do
      display_menu

      print "Choose an option: "
      choice = gets.chomp

      case choice
      when "1"
        @player_manager.add_player
      when "2"
        @player_manager.list_players
      when "3"
        @player_manager.update_player
      when "4"
        @player_manager.delete_player
      when "5"
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
    puts "== Player Management =="
    puts "1. Add player"
    puts "2. List players"
    puts "3. Update player"
    puts "4. Delete player"
    puts "5. Exit"
    puts
  end
end

Menu.new.run
