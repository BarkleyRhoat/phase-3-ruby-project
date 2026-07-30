module ConfirmationHelper
  def confirm?(message)
    input = Readline.readline("#{message} (y/n): ".yellow, true).chomp.downcase
    input == "y" || input == "yes"
  end
end