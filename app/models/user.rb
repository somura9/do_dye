class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :name,   presence: true, length: { maximum: 255 }
  validates :email,  presence: true, uniqueness: true
  validates :role,   presence: true

  has_many :works, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_works, through: :likes, source: :work

  enum role: { general: 0, admin: 1 }

  # 自分の作成したオブジェクトか確認する
  def own?(object)
    id == object.user_id
  end

  # 　自分かどうか確認する
  def me?(object)
    id == object.id
  end

  def like(work)
    like_works << work
  end

   def unlike(work)
    like_works.destroy(work)
  end

  def like?(work)
    like_works.include?(work)
  end
end
