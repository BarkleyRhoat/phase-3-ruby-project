# frozen_string_literal: true

require_relative "color_helper"

module SelectionHelper
  include ColorHelper

  def select_from_list(items, label, *columns)
    return nil if items.empty?

    table = Terminal::Table.new do |t|
      t.headings = ["#", *columns]
      t.rows = items.each_with_index.map do |item, index|
        [index + 1, *yield(item)]
      end
    end

    puts table

    input = Readline.readline(prompt("Enter #{label} number: "), true).chomp.to_i

    if input < 1 || input > items.length
      puts error("❌ #{label.capitalize} not found.")
      return nil
    end

    items[input - 1]
  end
end
