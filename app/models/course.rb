class Course < ActiveRecord::Base
  has_many :rounds, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :par, numericality: { greater_than_or_equal_to: 27, less_than_or_equal_to: 74}
end
