class RemoveImageFromPosts < ActiveRecord::Migration[7.0]
  def up
    remove_column :posts, :image
  end

  def down
    add_column :posts, :image, :string
  end
end
