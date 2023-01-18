class Embed < ApplicationRecord
  has_one :work_block, as: :blockable, dependent: :destroy
  has_one :work, through: :work_block

  validates :identifier,   presence: true
end
