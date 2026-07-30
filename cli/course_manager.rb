# frozen_string_literal: true

require "readline"
require "terminal-table"
require_relative "statistics"
require_relative "confirmation_helper"
require_relative "selection_helper"
require_relative "color_helper"

class CourseManager
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
        add_course
      when "2"
        list_courses
      when "3"
        show_record
      when "4"
        update_course
      when "5"
        delete_course
      when "6"
        break
      else
        puts error("Invalid option. Please try again.")
      end

      puts
    end
  end

    def show_record
      @statistics.course_records
    end

  def add_course
    name = Readline.readline(prompt("Enter course name: "), true)

    par = Readline.readline(prompt("Enter par: "), true).chomp.to_i

    course = Course.new(name: name, par: par)

    if course.save
      puts success("✅ Course '#{course.name}' created.")
    else
      puts error("❌ Failed to create course:")
      course.errors.full_messages.each { |msg| puts error(" - #{msg}") }
    end
  end

  def list_courses
    courses = Course.all

    if courses.empty?
      puts info("No courses found.")
      return courses
    end

    table = Terminal::Table.new do |t|
      t.headings = ["#", "Name", "Par", "Average Score"]
      t.rows = courses.each_with_index.map do |course, index|
        scores = course.rounds.map(&:score)
        average = scores.empty? ? "N/A" : (scores.sum.to_f / scores.count).round(1)
        [index + 1, course.name, course.par, average]
      end
    end

    puts table

    courses
  end

  def update_course
    course = select_course
    return unless course

    puts info("Current name: #{course.name}")
    name = Readline.readline(prompt("Enter new name (press Enter to keep '#{course.name}'): "), true)

    puts info("Current par: #{course.par}")
    par_input = Readline.readline(prompt("Enter new par (press Enter to keep #{course.par}): "), true).chomp
    par = par_input.empty? ? course.par : par_input.to_i

    course.name = name unless name.empty?
    course.par = par

    if course.save
      puts success("✅ Course updated to '#{course.name}' (Par #{course.par}).")
    else
      puts error("❌ Failed to update course:")
      course.errors.full_messages.each { |msg| puts error(" - #{msg}") }
    end
  end

  def delete_course
    course = select_course
    return unless course

    return unless confirm?("Delete course '#{course.name}' and all rounds played there?")

    course.destroy
    puts success("✅ Course '#{course.name}' deleted.")
  end

  private

  def display_menu
    puts header_border("\n==============================")
    puts header_title("      Course Management       ")
    puts header_border("==============================")
    puts "1. Add course"
    puts "2. List courses"
    puts "3. Course Records"
    puts "4. Update course"
    puts "5. Delete course"
    puts "6. Back to main menu"
    puts header_border("==============================\n")
  end

  def select_course
    select_from_list(Course.all, "course", "Name") { |course| [course.name] }
  end
end
