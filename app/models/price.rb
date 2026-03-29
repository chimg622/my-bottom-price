class Price < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  belongs_to :item

  validates :price, :quantity, :unit, :unit_price, presence: true
  validates :price, :quantity, numericality: {
    only_integer: true,
    greater_than: 0
  }

  enum unit: { gram: 0, piece: 1, ml: 2 }
end
