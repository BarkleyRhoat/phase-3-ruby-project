# frozen_string_literal: true

module ColorHelper
  def header_title(text)
    text.cyan.bold
  end

  def header_border(text)
    text.blue
  end

  def prompt(text)
    text.yellow
  end

  def success(text)
    text.green
  end

  def error(text)
    text.red
  end

  def info(text)
    text.light_blue
  end
end
