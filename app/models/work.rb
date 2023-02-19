class Work < ApplicationRecord
  mount_uploader :thumbnail, ThumbnailUploader
  validates :title, presence: true, length: { maximum: 255 }
  validates :summary, presence: true, length: { maximum: 255 }

  belongs_to :user
  has_many :work_blocks, inverse_of: :work
  has_many :sentences, through: :work_blocks, source: :blockable, source_type: 'Sentence'
  has_many :media, through: :work_blocks, source: :blockable, source_type: 'Medium'
  has_many :embeds, through: :work_blocks, source: :blockable, source_type: 'Embed'

  enum status: { publish: 0, hide: 1 }
end
