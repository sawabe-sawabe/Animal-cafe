class User < ApplicationRecord
  has_many :post_images
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites_images, through: :favorites, source: :post_image # 中間テーブルのfavoritesを通り、PostImageモデルのfavoritesインスタンスを取得するため
  has_many :post_comments_images, through: :post_comments, source: :post_image
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロー取得
  has_many :followings, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー取得
  has_many :following_users, through: :followers, source: :followed # 中間テーブルのfollowersを通り、Userモデルのfollowedインスタンスを取得するため
  has_many :follower_users, through: :followings, source: :follower # 中間テーブルのfollowingsを通り、Userモデルのfollowerインスタンスを取得するため
  attachment :image
  def follow(user_id)
        followers.create(followed_id: user_id)
  end
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user) # 今フォローしているか確認する
    following_users.include?(user)
  end
end
