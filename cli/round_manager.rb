# frozen_string_literal: true

require "readline"
require "terminal-table"
require_relative "confirmation_helper"
require_relative "selection_helper"
class RoundManager
  include ConfirmationHelper
  include SelectionHelper

  def run
    loop do
      display_menu

      choice = Readline.readline("Choose an option: ".red, true).chomp

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

    table = Terminal::Table.new do |t|
      t.headings = ["#", "Player", "Course", "Score", "Date"]
      t.rows = rounds.each_with_index.map do |round, index|
        [index + 1, round.player.name, round.course.name, round.score, round.date]
      end
    end

    puts table

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

    return unless confirm?("Delete round for '#{round.player.name}at #{round.course.name}?")

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

    scores = rounds.map(&:score)
    average = (scores.sum.to_f / scores.count).round(1)

    table = Terminal::Table.new do |t|
      t.headings = ["#", "Course", "Score", "Date"]
      t.rows = rounds.each_with_index.map do |round, index|
        [index + 1, round.course.name, round.score, round.date]
      end
    end

    puts "Rounds for #{player.name}:"
    puts table
    puts "Average score: #{average}"
  end

  def view_rounds_by_course
    course = select_course
    return unless course

    rounds = course.rounds
    if rounds.empty?
      puts "No rounds found at #{course.name}."
      return
    end

    table = Terminal::Table.new do |t|
      t.headings = ["#", "Player", "Score", "Date"]
      t.rows = rounds.each_with_index.map do |round, index|
        [index + 1, round.player.name, round.score, round.date]
      end
    end

    puts "Rounds at #{course.name}:"
    puts table
  end

  private

  def display_menu
    puts "\n==============================".green
    puts "        Round Management       ".red.bold
    puts "==============================".green
    puts "1. Add round"
    puts "2. List rounds"
    puts "3. Update round"
    puts "4. Delete round"
    puts "5. View rounds by player"
    puts "6. View rounds by course"
    puts "7. Back to main menu"
    puts "==============================\n".green
  end

  def select_player
    select_from_list(Player.all, "player", "Name") { |player| [player.name] }
  end

  def select_course
    select_from_list(Course.all, "course", "Name", "Par", "Avg Score") do |course|
      scores = course.rounds.map(&:score)
      average = scores.empty? ? "N/A" : (scores.sum.to_f / scores.count).round(1)
      [course.name, course.par, average]
    end
  end

  def select_round
    select_from_list(Round.all, "round", "Player", "Course", "Score", "Date") do |round|
      [round.player.name, round.course.name, round.score, round.date]
    end
  end
end
