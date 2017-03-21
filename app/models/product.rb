class Product < ApplicationRecord
  belongs_to :user, optional: true
  has_many :comments
  validates :name, presence: true, length: { in: 3..75 }
  validates :description, presence: true, length: { maximum: 1000 }
end
