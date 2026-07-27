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
end
