# frozen_string_literal: true

require "readline"
require "terminal-table"

class PlayerManager
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
        update_player
      when "4"
        delete_player
      when "5"
        break
      else
        puts "Invalid option. Please try again."
      end

      puts
    end
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
    puts "3. Update player"
    puts "4. Delete player"
    puts "5. Back to main menu"
    puts "==============================\n".green
  end

  def select_player
    players = list_players
    return nil if players.empty?

    input = Readline.readline("Enter player number: ", true).chomp.to_i
    player = players[input - 1]

    if player.nil?
      puts "❌ Player not found."
      return nil
    end

    player
  end
end
