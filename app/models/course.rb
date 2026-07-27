class Course < ActiveRecord::Base
  has_many :rounds

  validates :name, presence: true
  validates :par, numericality: { greater_than_or_equal_to: 27, less_than_or_equal_to: 74}
end
