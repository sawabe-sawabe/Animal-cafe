class CreateGroupBoards < ActiveRecord::Migration[5.2]
  def change
    create_table :group_boards do |t|
      t.integer :group_id
      t.integer :user_id
      t.text :message
      t.timestamps
    end
  end
end
