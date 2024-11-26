class OrderItem < ApplicationRecord
  acts_as_paranoid
  self.primary_key = :id

  belongs_to :product, foreign_key: :product_id, required: true
  belongs_to :order, foreign_key: :order_id, required: true

  acts_as_paranoid column: :deleted_at

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :product_id, presence: true
  validates :order_id, presence: true

  before_validation :set_default_timestamps, on: :create

  private

  def set_default_timestamps
    self.created_at ||= Time.current
    self.updated_at = Time.current
  end
end