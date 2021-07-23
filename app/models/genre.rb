class Genre < ApplicationRecord
 has_many :post_images,dependent: :destroy
 validates :name, presence: true ,length: { maximum: 20 }, uniqueness: true
end
