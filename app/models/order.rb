class Order < ApplicationRecord
  acts_as_paranoid

  self.primary_key = :id
  before_validation :set_default_order_date, on: :create

  has_many :order_items, dependent: :destroy
  belongs_to :user

  validates :order_date, presence: true
  validates :status, presence: true, length: { maximum: 50 }
  validates :user_id, presence: true

  private

  def set_default_order_date
    self.order_date ||= Time.current
  end
end