class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product, inverse_of: :comments

  validates_presence_of :product
  validates :description, presence: true, length: { in: 10..1000 }
end
