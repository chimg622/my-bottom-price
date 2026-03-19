class Shop < ApplicationRecord
  belongs_to :user
  has_many :prices

  validates :name, presence: true
end
