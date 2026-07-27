class Round < ActiveRecord::Base
  belongs_to :player
  belongs_to :course

validates :score, numericality: { greater_than_or_equal_to: 9 }
  validates :player, presence: true
  validates :course, presence: true
end
