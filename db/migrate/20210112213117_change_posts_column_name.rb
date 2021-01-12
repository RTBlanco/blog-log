class ChangePostsColumnName < ActiveRecord::Migration
  def change 
    rename_column :posts, :name, :title
  end
end
