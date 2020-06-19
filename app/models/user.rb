class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 6 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :name, presence: true
  validates :level, presence: true
  validates :email, uniqueness: true
end
