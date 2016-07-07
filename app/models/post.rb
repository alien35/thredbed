class Post < ActiveRecord::Base
  acts_as_votable
  scope :of_followed_users, -> (following_users) { where user_id: following_users }
  VALID_LINK_REGEX = /\Ahttp\.*/
  validates :link,  presence: true, format: { with: VALID_LINK_REGEX }
  validates :title, presence: true, length: { maximum: 100 }
  validates :commentary, presence: true
  validates :user_id, presence: true

  belongs_to :user
  has_many :comments,      dependent: :destroy
  has_many :notifications, dependent: :destroy
  before_save :get_image_from_link,
              if: ->(post) { post.link_changed? }
  has_attached_file :image, styles: { medium: "260x", thumb: "100x"},
                         default_url: 'https://s31.postimg.org/z6185cysb/question_mark.jpg'
  validates_attachment_content_type :image,
                                     content_type: /\Aimage\/.*\Z/

  def self.search(query)
    where("commentary LIKE ?", "%#{query}%")
  end

  private

        def get_image_from_link
          page = MetaInspector.new(link)
          return unless page.images.best.present?
          # block opens and closes meta file
          open(page.images.best) do |file|
            # self is not implicit in this case
            self.image = file
          end
        end

end
