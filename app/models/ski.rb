# frozen_string_literal: true

class Ski < ApplicationRecord
  belongs_to :user
  validates_presence_of :brand, :model, :grind

  scope :cold, -> { where(grind: :cold) }
  scope :warm, -> { where(grind: :warm) }
  scope :wet, -> { where(grind: :wet) }
end
