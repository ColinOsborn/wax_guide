class Ski < ApplicationRecord
  validates :brand, presence: true
  validates :model, presence: true

  belongs_to :user
end
