class Player < ActiveRecord::Base
  has_many :rounds

  validates :name, presence: true
end
