class Product < ApplicationRecord
  belongs_to :user
  has_many :comments, inverse_of: :product, dependent: :destroy
  accepts_nested_attributes_for :comments

  validates :name, presence: true, uniqueness: true, length: { in: 3..75 }
  validates :description, presence: true, length: { maximum: 1000 }

  paginates_per 15
end
