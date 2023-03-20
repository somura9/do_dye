class Tag < ApplicationRecord
  has_many :work_tag_relations
  has_many :works, through: :work_tag_relations
end
