# frozen_string_literal: true

require "readline"
require "terminal-table"
require_relative "statistics"
require_relative "confirmation_helper"
require_relative "selection_helper"

class PlayerManager
  include ConfirmationHelper
  include SelectionHelper

  def initialize
    @statistics = Statistics.new
  end

  def run
    loop do
      display_menu

      choice = Readline.readline("Choose an option: ".red, true).chomp

      case choice
      when "1"
        add_player
      when "2"
        list_players
      when "3"
        show_leaderboard
      when "4"
        update_player
      when "5"
        delete_player
      when "6"
        break
      else
        puts "Invalid option. Please try again."
      end

      puts
    end
  end

  def show_leaderboard
    @statistics.player_leaderboard
  end

  def add_player
    name = Readline.readline("Enter player name: ", true)

    player = Player.new(name: name)

    if player.save
      puts "✅ Player '#{player.name}' created."
    else
      puts "❌ Failed to create player:"
      player.errors.full_messages.each { |msg| puts " - #{msg}" }
    end
  end

  def list_players
    players = Player.all

    if players.empty?
      puts "No players found."
      return players
    end

    table = Terminal::Table.new do |t|
      t.headings = ["#", "Name"]
      t.rows = players.each_with_index.map do |player, index|
        [index + 1, player.name]
      end
    end

    puts table

    players
  end

  def update_player
    player = select_player
    return unless player

    puts "Current name: #{player.name}"
    name = Readline.readline("Enter new name (press Enter to keep '#{player.name}'): ", true)

    return if name.empty?

    player.name = name

    if player.save
      puts "✅ Player updated to '#{player.name}'."
    else
      puts "❌ Failed to update player:"
      player.errors.full_messages.each { |msg| puts " - #{msg}" }
    end
  end

  def delete_player
    player = select_player
    return unless player

    return unless confirm?("Delete player '#{player.name}' and all rounds?")

    player.destroy
    puts "✅ Player '#{player.name}' deleted."
  end

  private

  def display_menu
    puts "\n==============================".green
    puts "      Player Management       ".red.bold
    puts "==============================".green
    puts "1. Add player"
    puts "2. List players"
    puts "3. Leaderboard"
    puts "4. Update player"
    puts "5. Delete player"
    puts "6. Back to main menu"
    puts "==============================\n".green
  end

  def select_player
    select_from_list(Player.all, "player", "Name") { |player| [player.name] }
  end
end
