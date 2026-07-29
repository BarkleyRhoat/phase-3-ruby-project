class Player < ActiveRecord::Base
  has_many :rounds, dependent: :destroy

  validates :name, presence: true
end
