class Price < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  belongs_to :item

  validates :price, :quantity, :unit, presence: true
  validates :price, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 100,
    less_than_or_equal_to: 9_999_999
  }

  enum unit: { gram: 0, piece: 1, ml: 2 }
end
