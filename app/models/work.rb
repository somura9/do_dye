class Work < ApplicationRecord
  mount_uploader :thumbnail, ThumbnailUploader
  validates :title, presence: true, length: { maximum: 255 }
  validates :summary, presence: true, length: { maximum: 255 }
  validates :status, presence: true

  belongs_to :user
  has_many :work_blocks, inverse_of: :work
  has_many :sentences, through: :work_blocks, source: :blockable, source_type: 'Sentence'
  has_many :media, through: :work_blocks, source: :blockable, source_type: 'Medium'
  has_many :embeds, through: :work_blocks, source: :blockable, source_type: 'Embed'

  has_many :work_tag_relations
  has_many :tags, through: :work_tag_relations, dependent: :destroy

  enum status: { publish: 0, hide: 1 }

  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end

    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["title", "summary"]
end
end
