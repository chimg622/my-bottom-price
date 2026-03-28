class Shop < ApplicationRecord
  belongs_to :user
  has_many :prices

  validates :name, presence: true, length: { maximum: 30 }
  validates :name, uniqueness: { scope: :user_id, message: 'は既に登録されています' }
end
