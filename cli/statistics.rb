# frozen_string_literal: true

require "terminal-table"
require_relative "color_helper"

class Statistics
  include ColorHelper

  def player_leaderboard
    players = Player.all

    if players.empty?
      puts info("No players found.")
      return
    end

    rows = players.map do |player|
      rounds = player.rounds
      if rounds.empty?
        [player.name, 0, "N/A", "N/A"]
      else
        scores = rounds.map(&:score)
        [
          player.name,
          rounds.count,
          (scores.sum.to_f / scores.count).round(1), 
          scores.min
        ]
      end
    end

    rows.sort_by! { |row| row[2].is_a?(Numeric) ? row[2] : Float::INFINITY }
    table = Terminal::Table.new do |t|
      t.headings = ["Rank", "Player", "Rounds", "Avg Score", "Best Round"]
      t.rows = rows.each_with_index.map { |row, index| [index + 1, *row] }
    end

    puts table
  end

  def course_records
    courses = Course.all

    if courses.empty?
      puts info("No courses found.")
      return
    end

    rows = courses.map do |course|
      rounds = course.rounds
      if rounds.empty?
        [course.name, "N/A", "N/A"]
      else
        best_round = rounds.min_by(&:score)
        [
          course.name,
          best_round.score,
          best_round.player.name
        ]
      end
    end

    rows.sort_by! { |row| row[1].is_a?(Numeric) ? row[1] : Float::INFINITY }

    table = Terminal::Table.new do |t|
      t.headings = ["Rank", "Course", "Best Score", "Player"]
      t.rows = rows.each_with_index.map { |row, index| [index + 1, *row] }
    end

    puts table
  end
end