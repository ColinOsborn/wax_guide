class User < ApplicationRecord
  authenticates_with_sorcery!
  validates_confirmation_of :password, message: "Must match confirmation", if: :password

  has_many :skis
end
