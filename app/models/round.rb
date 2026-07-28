class Round < ActiveRecord::Base
  belongs_to :player
  belongs_to :course

  validates :score, numericality: { greater_than_or_equal_to: 9 }
  validates :player, presence: true
  validates :course, presence: true

  validate :date_cannot_be_in_the_future

  def date_cannot_be_in_the_future
    return if date.blank?

    parsed_date = Date.parse(date)
    if parsed_date > Date.today
      errors.add(:date, "cannot be in the future")
    end
  rescue Date::Error
    errors.add(:date, "is not a valid date")
  end
end
