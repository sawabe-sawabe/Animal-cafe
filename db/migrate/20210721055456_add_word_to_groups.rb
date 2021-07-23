class AddWordToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :word, :string
  end
end
