# frozen_string_literal: true

require "readline"
require "terminal-table"
require_relative "statistics"
require_relative "confirmation_helper"
require_relative "selection_helper"
require_relative "color_helper"

class PlayerManager
  include ConfirmationHelper
  include SelectionHelper
  include ColorHelper

  def initialize
    @statistics = Statistics.new
  end

  def run
    loop do
      display_menu

      choice = Readline.readline(prompt("Choose an option: "), true).chomp

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
        puts error("Invalid option. Please try again.")
      end

      puts
    end
  end

  def show_leaderboard
    @statistics.player_leaderboard
  end

  def add_player
    name = Readline.readline(prompt("Enter player name: "), true)

    player = Player.new(name: name)

    if player.save
      puts success("✅ Player '#{player.name}' created.")
    else
      puts error("❌ Failed to create player:")
      player.errors.full_messages.each { |msg| puts error(" - #{msg}") }
    end
  end

  def list_players
    players = Player.all

    if players.empty?
      puts info("No players found.")
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

    puts info("Current name: #{player.name}")
    name = Readline.readline(prompt("Enter new name (press Enter to keep '#{player.name}'): "), true)

    return if name.empty?

    player.name = name

    if player.save
      puts success("✅ Player updated to '#{player.name}'.")
    else
      puts error("❌ Failed to update player:")
      player.errors.full_messages.each { |msg| puts error(" - #{msg}") }
    end
  end

  def delete_player
    player = select_player
    return unless player

    return unless confirm?("Delete player '#{player.name}' and all rounds?")

    player.destroy
    puts success("✅ Player '#{player.name}' deleted.")
  end

  private

  def display_menu
    puts header_border("\n==============================")
    puts header_title("      Player Management       ")
    puts header_border("==============================")
    puts "1. Add player"
    puts "2. List players"
    puts "3. Leaderboard"
    puts "4. Update player"
    puts "5. Delete player"
    puts "6. Back to main menu"
    puts header_border("==============================\n")
  end

  def select_player
    select_from_list(Player.all, "player", "Name") { |player| [player.name] }
  end
end
