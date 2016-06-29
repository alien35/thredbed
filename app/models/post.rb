class Post < ActiveRecord::Base
  has_attached_file :image, styles: { medium: "260x", thumb: "100x"},
                         default_url: 'question-mark-comlink.jpg'
  validates_attachment_content_type :image,
                                     content_type: /\Aimage\/.*\Z/

end
