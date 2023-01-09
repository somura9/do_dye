class Medium < ApplicationRecord
  mount_uploader :name, NameUploader
  has_one :work_block, as: :blockable, dependent: :destroy
  has_one :work, through: :work_block
end
