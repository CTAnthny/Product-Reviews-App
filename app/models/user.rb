class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :comments
  has_many :products
  validates :first_name, presence: true, length: { in: 2..15 }
  validates :last_name, presence: true, length: { in: 2..25 }
  validates :email, presence: true, uniqueness: true
end
