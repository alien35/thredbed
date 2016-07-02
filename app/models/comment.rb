class Comment < ActiveRecord::Base
  acts_as_votable

  validates :content, presence: true
  belongs_to :user
  belongs_to :post
end
