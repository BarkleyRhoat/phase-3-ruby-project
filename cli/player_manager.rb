# frozen_string_literal: true

require "readline"

class PlayerManager
  def run
    loop do
      display_menu

      choice = Readline.readline("Choose an option: ", true).chomp

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
      return
    end

    puts "Players:"
    players.each do |player|
      puts " #{player.id}. #{player.name}"
    end
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
    puts "== Player Management =="
    puts "1. Add player"
    puts "2. List players"
    puts "3. Update player"
    puts "4. Delete player"
    puts "5. Back to main menu"
    puts
  end

  def select_player
    list_players

    id = Readline.readline("Enter player number: ", true)
    player = Player.find_by(id: id)

    if player.nil?
      puts "❌ Player not found."
      return nil
    end

    player
  end
end
