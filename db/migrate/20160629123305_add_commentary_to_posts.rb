class AddCommentaryToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :commentary, :text
  end
end
