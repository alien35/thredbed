class User < ActiveRecord::Base
  before_save :capitalize_name
  before_save :downcase_email

  #after_create :send_create_mail
  def send_create_mail
    UserMailer.send_signup_email(self).deliver
  end


  acts_as_voter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :posts,         dependent: :destroy
  has_many :comments,      dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable
  validates :user_name,
             presence: true,
             length: { minimum: 4, maximum: 16 }
  validates :bio, length: {maximum: 20 }
  has_attached_file :avatar, styles: { medium: '300x300#', thumb: "30x30#" }
validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  # Follows a user.
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  private

    def capitalize_name
      self.user_name = user_name.downcase.capitalize
    end

    def downcase_email
      self.email = email.downcase
    end


end
#152
