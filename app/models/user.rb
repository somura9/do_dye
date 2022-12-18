class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :works, dependent: :destroy
end
