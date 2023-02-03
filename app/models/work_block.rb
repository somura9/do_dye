class WorkBlock < ApplicationRecord
  belongs_to :work
  belongs_to :blockable, polymorphic: true, dependent: :destroy
  belongs_to :tab

  class << self
    def blockable_types
      %w[Sentence Medium Embed]
    end

    def valid_blockable_type?(type)
      blockable_types.include?(type.to_s.classify)
    end
  end

  def sentence?
    blockable.is_a?(Sentence)
  end

  def medium?
    blockable.is_a?(Medium)
  end

  def embed?
    blockable.is_a?(Embed)
  end
end
