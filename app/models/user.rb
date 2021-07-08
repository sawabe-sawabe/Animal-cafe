class User < ApplicationRecord
  has_many :post_images
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
