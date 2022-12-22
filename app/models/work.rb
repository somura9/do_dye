class Work < ApplicationRecord
  mount_uploader :thumbnail, ThumbnailUploader
  validates :title,   presence: true, length: { maximum: 255 }
  validates :summary,    presence: true, length: { maximum: 255 }

  belongs_to :user
end
