class Post < ActiveRecord::Base
  acts_as_votable
  acts_as_taggable_on :tags
  scope :of_followed_users, -> (following_users) { where user_id: following_users }
  before_save :ends_with_q
  before_save :get_image_from_link,
              if: ->(post) { post.link_changed? }
  VALID_LINK_REGEX = /\Ahttp\.*/
  validates :link,  presence: true, format: { with: VALID_LINK_REGEX }
  validates :title, length: { maximum: 101 }
  validates :commentary, presence: true
  validates :user_id, presence: true
  validates :tag_list, presence: true
  belongs_to :user
  has_many :comments,      dependent: :destroy
  has_many :responses,     dependent: :destroy
  has_many :notifications, dependent: :destroy
  #validates :image_link, presence: true
  has_attached_file :image, styles: { medium: "260x", thumb: "100x"},
                         default_url: 'https://s31.postimg.org/z6185cysb/question_mark.jpg'
  validates_attachment_content_type :image,
                                     content_type: /\Aimage\/.*\Z/

  def self.search(query)
    where("title LIKE :search OR commentary LIKE :search OR link LIKE :search", search: "%#{query}%")
  end

  def ends_with_q
    self.title = (/\A.*\?\z/).match(self.title).nil? ? title.strip + "?" : title.strip
  end

  private

        def get_image_from_link
          page = MetaInspector.new(link)
          self.image_link = page.images.best.present? ? page.images.best : "https://s32.postimg.org/7wdmzydut/hintergrund_tapete_1460040441_Mp1.jpg"
        end

end
