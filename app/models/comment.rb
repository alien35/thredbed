class Comment < ActiveRecord::Base
  acts_as_votable
  scope :of_followed_users, -> (following_users) { where user_id: following_users }

  validates :content, presence: true, length: { minimum: 10 }
  belongs_to :user
  belongs_to :post
  has_many :notifications, dependent: :destroy
  has_many :responses, dependent: :destroy
end
