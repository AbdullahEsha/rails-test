class Category < ApplicationRecord
  acts_as_paranoid

  self.primary_key = :id
  has_many :subcategories, class_name: 'Category', foreign_key: :parent_id, dependent: :destroy
  has_many :products, dependent: :nullify

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end