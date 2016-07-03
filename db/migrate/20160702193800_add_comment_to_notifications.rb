class AddCommentToNotifications < ActiveRecord::Migration
  def change
    add_reference :notifications, :comment, index: true, foreign_key: true
  end
end
