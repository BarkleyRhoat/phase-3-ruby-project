# frozen_string_literal: true

require "readline"

class CourseManager
  def run
    loop do
      display_menu

      print "Choose an option: "
      choice = gets.chomp

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
        puts "Invalid option. Please try again."
      end

      puts
    end
  end

  def add_course
    name = Readline.readline("Enter course name: ", true)

    par = Readline.readline("Enter par: ", true).chomp.to_i

    course = Course.new(name: name, par: par)

    if course.save
      puts "✅ Course "
    else
      puts "❌ Failed to create course:"
      course.errors.full_messages.each { |msg| puts " - #{msg}" }
    end
  end

  def list_courses
    courses = Course.all

    if courses.empty?
      puts "No courses found."
      return
    end

    puts "Courses:"
    courses.each do |course|
      puts " #{course.id}. #{course.name} (Par #{course.par})"
    end
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
    puts "== Course Management =="
    puts "1. Add course"
    puts "2. List courses"
    puts "3. Update course"
    puts "4. Delete course"
    puts "5. Back to main menu"
    puts
  end

  def select_course
    list_courses

    id = Readline.readline("Enter course number: ", true)
    course = Course.find_by(id: id)

    if course.nil?
      puts "❌ Course not found."
      return nil
    end

    course
  end
end