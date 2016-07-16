class AddImageLinkToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :image_link, :text
  end
end
