class Price < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  belongs_to :item

  before_validation :calculate_unit_price

  validates :price, :quantity, :unit, :unit_price, presence: true
  validates :price, :quantity, numericality: {
    only_integer: true,
    greater_than: 0
  }

  enum unit: { gram: 0, piece: 1, ml: 2 }

  private

  def calculate_unit_price
    return if price.blank? || quantity.blank? || quantity <= 0 || unit.blank?

    base = piece? ? 1 : 100
    self.unit_price = ((price.to_f / quantity) * base).round(1)
  end
end
