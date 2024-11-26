class User < ApplicationRecord
  # Enable Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Soft deletes
  acts_as_paranoid

  # Associations
  belongs_to :role

  # Validations
  validates :name, presence: true, length: { maximum: 255 }
end