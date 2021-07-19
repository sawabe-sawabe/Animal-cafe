class User < ApplicationRecord
  has_many :post_images
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites_images, through: :favorites, source: :post_image # 中間テーブルのfavoritesを通り、PostImageモデルのfavoritesインスタンスを取得するため
  has_many :post_comments_images, through: :post_comments, source: :post_image
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロー取得
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロワー取得
  has_many :followers, through: :reverse_of_relationships, source: :follower# 中間テーブルのを通り、Userモデルのfollowedインスタンスを取得するため
  has_many :followings, through: :relationships, source: :followed # 中間テーブルを通り、Userモデルのfollowerインスタンスを取得するため
  has_many :user_rooms
  has_many :chats
  has_many :rooms, through: :user_rooms

  attachment :profile_image


  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true #同じ名前は使えないようにするため
  validates :word, length: { maximum: 30 }

  def follow(user_id)# フォロー
        relationships.create(followed_id: user_id)
  end
  def unfollow(user_id)# フォロー解除
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user) # 今フォローしているか確認するため
    followings.include?(user)
  end


  def self.search(search,word) #searchパラメーターを使用して検索方法を分岐
    if  search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")

    elsif search == "backward_match"
        @user = User.where("name LIKE?","%#{word}%")

    elsif search == "perfect_match"
        @user = User.where("name LIKE?","#{word}")

    elsif search == "partial_match"
        @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end

end
