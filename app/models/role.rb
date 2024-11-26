class Role < ApplicationRecord
  acts_as_paranoid

  include ActiveRecord::SecureToken

  has_many :users, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # Remove the manual id generation
  # before_create :generate_secure_token

  private

  # You don't need to manually set the ID
  # def generate_secure_token
  #   self.id ||= SecureRandom.uuid
  # end
end
