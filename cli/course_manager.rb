# frozen_string_literal: true

require "readline"
require "terminal-table"
require_relative "statistics"

class CourseManager

  def initialize
    @statistics = Statistics.new
  end

  def run
    loop do
      display_menu

      choice = Readline.readline("Choose an option: ".red, true).chomp

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
        puts "Invalid option. Please try again."
      end

      puts
    end
  end

    def show_record
      @statistics.course_records
    end

  def add_course
    name = Readline.readline("Enter course name: ", true)

    par = Readline.readline("Enter par: ", true).chomp.to_i

    course = Course.new(name: name, par: par)

    if course.save
      puts "✅ Course '#{course.name}' created."
    else
      puts "❌ Failed to create course:"
      course.errors.full_messages.each { |msg| puts " - #{msg}" }
    end
  end

  def list_courses
    courses = Course.all

    if courses.empty?
      puts "No courses found."
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

    puts "Current name: #{course.name}"
    name = Readline.readline("Enter new name (press Enter to keep '#{course.name}'): ", true)

    puts "Current par: #{course.par}"
    par_input = Readline.readline("Enter new par (press Enter to keep #{course.par}): ", true).chomp
    par = par_input.empty? ? course.par : par_input.to_i

    course.name = name unless name.empty?
    course.par = par

    if course.save
      puts "✅ Course updated to '#{course.name}' (Par #{course.par})."
    else
      puts "❌ Failed to update course:"
      course.errors.full_messages.each { |msg| puts " - #{msg}" }
    end
  end

  def delete_course
    course = select_course
    return unless course

    course.destroy
    puts "✅ Course '#{course.name}' deleted."
  end

  private

  def display_menu
    puts "\n==============================".green
    puts "      Course Management       ".red.bold
    puts "==============================".green
    puts "1. Add course"
    puts "2. List courses"
    puts "3. Course Records"
    puts "4. Update course"
    puts "5. Delete course"
    puts "6. Back to main menu"
    puts "==============================\n".green
  end

  def select_course
    courses = list_courses
    return nil if courses.empty?

    input = Readline.readline("Enter course number: ", true).chomp.to_i
    course = courses[input - 1]

    if course.nil?
      puts "❌ Course not found."
      return nil
    end

    course
  end
end
