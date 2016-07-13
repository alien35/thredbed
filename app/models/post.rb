class Post < ActiveRecord::Base
  acts_as_votable
  acts_as_taggable_on :tags
  scope :of_followed_users, -> (following_users) { where user_id: following_users }
  before_save :ends_with_q
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
  before_save :get_image_from_link,
              if: ->(post) { post.link_changed? }
  has_attached_file :image, styles: { medium: "260x", thumb: "100x"},
                         default_url: 'https://s31.postimg.org/z6185cysb/question_mark.jpg'
  validates_attachment_content_type :image,
                                     content_type: /\Aimage\/.*\Z/

  def self.search(query)
    where("title LIKE :search OR commentary LIKE :search OR link LIKE :search", search: "%#{query}%")
  end

  def ends_with_q
    a = self.title.strip
    a = (/\A.*\?\z/).match(self.title).nil? && self.title.length > 0 ? title + "?" : title
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
