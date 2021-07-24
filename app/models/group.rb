class Group < ApplicationRecord
  has_many :group_users,dependent: :destroy
  has_many:users, through: :group_users,dependent: :destroy
  has_many :group_boards, dependent: :destroy

  attachment :profile_image

  validates :name, presence: true,uniqueness: true #同じ名前は使えないようにするため
  validates :profile_image, presence: true
  validates :introduction,presence: true
  validates :word, length: { maximum: 30 }

  def joined_by?(user)
    group_users.where(user_id: user.id).exists? #グループにユーザーが加入しているかを確認
  end

  def self.search(search,word) #searchパラメーターを使用して検索方法を分岐
    if  search == "forward_match"
      @group = Group.where("name LIKE?","#{word}%")

    elsif search == "backward_match"
      @group = Group.where("name LIKE?","%#{word}%")

    elsif search == "perfect_match"
      @group = Group.where("name LIKE?","#{word}")

    elsif search == "partial_match"
      @group = Group.where("name LIKE?","%#{word}%")
    else
      @group = Group.all
    end
  end

end
