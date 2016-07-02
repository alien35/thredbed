class User < ActiveRecord::Base
  acts_as_voter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :posts,    dependent: :destroy
  has_many :comments, dependent: :destroy
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable
  validates :user_name,
             presence: true,
             length: { minimum: 4, maximum: 16 }
  has_attached_file :avatar, styles: { medium: '30x30#', thumb: "30x30#" }
validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
#152
