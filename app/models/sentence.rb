class Sentence < ApplicationRecord
  has_one :work_block, as: :blockable, dependent: :destroy
  has_one :work, through: :work_block

  validates :body, presence: true
end
