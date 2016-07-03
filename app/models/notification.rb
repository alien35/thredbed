class Notification < ActiveRecord::Base
  belongs_to :notified_by, class_name: 'User'
  belongs_to :user
  belongs_to :post
  belongs_to :comment

  validates :user_id, :notified_by_id, :post_id, :comment_id, :notice_type, presence: true
end
