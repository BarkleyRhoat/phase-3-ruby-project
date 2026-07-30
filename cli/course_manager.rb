# frozen_string_literal: true

require "readline"
require "terminal-table"
require_relative "color_helper"

class CourseManager
  include ColorHelper

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
        update_course
      when "4"
        delete_course
      when "5"
        break
      else
        puts error("Invalid option. Please try again.")
      end

      puts
    end
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
      t.headings = ["#", "Name", "Par"]
      t.rows = courses.each_with_index.map do |course, index|
        [index + 1, course.name, course.par]
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
    puts "3. Update course"
    puts "4. Delete course"
    puts "5. Back to main menu"
    puts header_border("==============================\n")
  end

  def select_course
    courses = list_courses
    return nil if courses.empty?

    input = Readline.readline(prompt("Enter course number: "), true).chomp.to_i
    course = courses[input - 1]

    if course.nil?
      puts error("❌ Course not found.")
      return nil
    end

    course
  end
end
