class Notification < ActiveRecord::Base
  belongs_to :notified_by, class_name: 'User'
  belongs_to :user
  belongs_to :post

  validates :user_id, :notified_by_id, :notice_type, presence: true
#removed post_id from validation
end
