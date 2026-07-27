# frozen_string_literal: true

require_relative "../config/environment"

puts "🌱 Seeding golf data..."

Player.destroy_all
Course.destroy_all
Round.destroy_all

barkley = Player.create!(name: "Barkley")
tom = Player.create!(name: "Tom")
kyle = Player.create!(name: "Kyle")

augusta = Course.create!(name: "Augusta National", par: 72)
pebble = Course.create!(name: "Pebble Beach", par: 72)
standrews = Course.create!(name: "St Andrews", par: 72)
downriver = Course.create!(name: "Down River", par: 72)

Round.create!(player: barkley, course: augusta, score: 72, date: "2024-04-15")
Round.create!(player: tom, course: pebble, score: 75, date: "2024-05-20")
Round.create!(player: kyle, course: standrews, score: 70, date: "2024-06-10")
Round.create!(player: barkley, course: pebble, score: 68, date: "2024-07-05")
Round.create!(player: barkley, course: downriver, score: 88, date: "2026-05-05")

puts "✅ Done seeding!"
puts "   Players: #{Player.count}"
puts "   Courses: #{Course.count}"
puts "   Rounds: #{Round.count}"
