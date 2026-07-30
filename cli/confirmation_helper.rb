# frozen_string_literal: true

require_relative "color_helper"

module ConfirmationHelper
  include ColorHelper

  def confirm?(message)
    input = Readline.readline(prompt("#{message} (y/n): "), true).chomp.downcase
    input == "y" || input == "yes"
  end
end
