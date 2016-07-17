class Response < ActiveRecord::Base
  acts_as_votable
  belongs_to :user
  belongs_to :post
  belongs_to :comment
  validates :content, presence: true, length: { minimum: 10 }
end
