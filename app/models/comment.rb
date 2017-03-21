class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :product
  validates :description, presence: true, length: { in: 10..1000 }
end
