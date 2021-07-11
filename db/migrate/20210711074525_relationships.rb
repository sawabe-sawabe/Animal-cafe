class Relationships < ActiveRecord::Migration[5.2]
  def change
    add_index :relationships, :followed_id #検索速度を上げるためindexを張った
    add_index :relationships, %i(follower_id followed_id), unique: true#同じ人をフォローするのを防ぐため
  
  end
end
