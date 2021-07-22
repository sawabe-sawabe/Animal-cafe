class Group < ApplicationRecord
  has_many :group_users,dependent: :destroy
  has_many:users, through: :group_users,dependent: :destroy
  attachment :profile_image
  

  def joined_by?(user)
    group_users.where(user_id: user.id).exists? #グループにユーザーが加入しているかを確認
  end


end
