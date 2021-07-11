class PostImage < ApplicationRecord
   belongs_to :user
   belongs_to :genre
   attachment :image
   has_many :favorites, dependent: :destroy
   has_many :post_comments, dependent: :destroy
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?  #ユーザーidがテーブル内に存在するか確認するため
  end

end
