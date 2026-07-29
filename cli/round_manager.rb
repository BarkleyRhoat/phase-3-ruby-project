# frozen_string_literal: true

require "readline"

class RoundManager
  def run
    loop do
      display_menu

      choice = Readline.readline("Choose an option: ", true).chomp

      case choice
      when "1"
        add_round
      when "2"
        list_rounds
      when "3"
        update_round
      when "4"
        delete_round
      when "5"
        view_rounds_by_player
      when "6"
        view_rounds_by_course
      when "7"
        break
      else
        puts "Invalid option. Please try again."
      end

      puts
    end
  end

  def add_round
    player = select_player
    return unless player

    course = select_course
    return unless course

    score = Readline.readline("Enter score: ", true).chomp.to_i
    date = Readline.readline("Enter date (YYYY-MM-DD): ", true)

    round = Round.new(player: player, course: course, score: score, date: date)

    if round.save
      puts "✅ Round logged for #{player.name} at #{course.name}."
    else
      puts "❌ Failed to log round:"
      round.errors.full_messages.each { |msg| puts " - #{msg}" }
    end
  end

  def list_rounds
    rounds = Round.all

    if rounds.empty?
      puts "No rounds found."
      return rounds
    end

    puts "Rounds:"
    rounds.each_with_index do |round, index|
      puts " #{index + 1}. #{round.player.name} | #{round.course.name} | Score #{round.score} | #{round.date}"
    end

    rounds
  end

  def update_round
    round = select_round
    return unless round

    puts "Current score: #{round.score}"
    score_input = Readline.readline("Enter new score (press Enter to keep #{round.score}): ", true).chomp
    score = score_input.empty? ? round.score : score_input.to_i

    puts "Current date: #{round.date}"
    date = Readline.readline("Enter new date (press Enter to keep '#{round.date}'): ", true)

    round.score = score
    round.date = date unless date.empty?

    if round.save
      puts "✅ Round updated."
    else
      puts "❌ Failed to update round:"
      round.errors.full_messages.each { |msg| puts " - #{msg}" }
    end
  end

  def delete_round
    round = select_round
    return unless round

    round.destroy
    puts "✅ Round deleted."
  end

  def view_rounds_by_player
    player = select_player
    return unless player

    rounds = player.rounds
    if rounds.empty?
      puts "No rounds found for #{player.name}."
      return
    end

    puts "Rounds for #{player.name}:"
    rounds.each_with_index do |round, index|
      puts " #{index + 1}. #{round.course.name} | Score #{round.score} | #{round.date}"
    end
  end

  def view_rounds_by_course
    course = select_course
    return unless course

    rounds = course.rounds
    if rounds.empty?
      puts "No rounds found at #{course.name}."
      return
    end

    puts "Rounds at #{course.name}:"
    rounds.each_with_index do |round, index|
      puts " #{index + 1}. #{round.player.name} | Score #{round.score} | #{round.date}"
    end
  end

  private

  def display_menu
    puts "== Round Management =="
    puts "1. Add round"
    puts "2. List rounds"
    puts "3. Update round"
    puts "4. Delete round"
    puts "5. View rounds by player"
    puts "6. View rounds by course"
    puts "7. Back to main menu"
    puts
  end

  def select_player
    players = Player.all

    if players.empty?
      puts "No players found."
      return nil
    end

    puts "Players:"
    players.each_with_index do |player, index|
      puts " #{index + 1}. #{player.name}"
    end

    input = Readline.readline("Enter player number: ", true).chomp.to_i
    player = players[input - 1]

    puts "❌ Player not found." if player.nil?

    player
  end

  def select_course
    courses = Course.all

    if courses.empty?
      puts "No courses found."
      return nil
    end

    puts "Courses:"
    courses.each_with_index do |course, index|
      puts " #{index + 1}. #{course.name} (Par #{course.par})"
    end

    input = Readline.readline("Enter course number: ", true).chomp.to_i
    course = courses[input - 1]

    puts "❌ Course not found." if course.nil?

    course
  end

  def select_round
    rounds = list_rounds
    return nil if rounds.empty?

    input = Readline.readline("Enter round number: ", true).chomp.to_i
    round = rounds[input - 1]

    puts "❌ Round not found." if round.nil?

    round
  end
end
