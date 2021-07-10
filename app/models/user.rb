class User < ApplicationRecord
  has_many :post_images
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
end
