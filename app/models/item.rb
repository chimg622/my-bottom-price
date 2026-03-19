class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :prices

  validates :name, :unit, :category_id, presence: true

  enum unit: { gram: 0, piece: 1, ml: 2 }
end
