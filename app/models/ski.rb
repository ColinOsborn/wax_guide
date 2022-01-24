# frozen_string_literal: true

class Ski < ApplicationRecord
  belongs_to :user
  validates_presence_of :brand, :model, :grind
  
  def self.cold
    where(grind: 'cold')
  end

  def self.warm
    where(grind: 'warm')
  end

  def self.wet
    where(grind: 'wet')
  end
end
