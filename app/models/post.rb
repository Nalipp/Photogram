class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :image, presence: true
  has_attached_file :image, styles: { thumb: "x200", medium: "x300" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
