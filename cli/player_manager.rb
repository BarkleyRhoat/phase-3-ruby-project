# frozen_string_literal: true

require "readline"

class PlayerManager
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

  private

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
