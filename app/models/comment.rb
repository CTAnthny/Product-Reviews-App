class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :description, presence: true, length: { in: 10..1000 }
end
