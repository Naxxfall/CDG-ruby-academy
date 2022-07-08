class ChangePosts < ActiveRecord::Migration[7.0]
  def change
    change_column :posts, :caption, :text, null: false
    change_column :posts, :image_data, :text, null: false
  end
end
