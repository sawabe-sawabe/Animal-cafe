class CreatePostImages < ActiveRecord::Migration[5.2]
  def change
    create_table :post_images do |t|
      t.integer :user_id
      t.integer :genre_id
      t.text :image_id
      t.string :title
      t.text :caption

      t.timestamps
    end
  end
end
