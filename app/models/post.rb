class Post < ApplicationRecord
  include ImageUploader::Attachment(:image)
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :caption, presence: true
  validates :image_data, presence: true
end