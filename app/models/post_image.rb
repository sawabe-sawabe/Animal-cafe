class PostImage < ApplicationRecord
   belongs_to :user
   belongs_to :genre
   attachment :image
   has_many :favorites, dependent: :destroy
   has_many :post_comments, dependent: :destroy

   validates :image, presence: true
   validates :genre, presence: true
   validates :title, presence: true


  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?  #ユーザーidがテーブル内に存在するか確認するため
  end
  def self.match(value)
  @post_image = PostImage.where(genre_id: value)
  end
  def self.search(search,word)
    if  search == "forward_match"
      @post_image = PostImage.where("title LIKE?","#{word}%")

    elsif search == "backward_match"
      @post_image = PostImage.where("title LIKE?","%#{word}%")

    elsif search == "perfect_match"
      @post_image = PostImage.where("title LIKE?","#{word}")

    elsif search == "partial_match"
      @post_image = PostImage.where("title LIKE?","%#{word}%")
    else
      @post_image = PostImage.all
    end
  end
end
