class Product < ApplicationRecord
  acts_as_paranoid

  self.primary_key = :id

  belongs_to :category, foreign_key: :category_id
  has_many :order_items, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  # Remove validation for `description` if it's optional.
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.01 }
  validates :stock_quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :category_id, presence: true

  before_save :ensure_uuid
  after_initialize :set_default_values, if: :new_record?

  private

  def ensure_uuid
    self.id ||= SecureRandom.uuid
  end

  def set_default_values
    self.created_at ||= Time.current
    self.updated_at ||= Time.current
  end
end
