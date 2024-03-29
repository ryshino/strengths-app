class Episode < ApplicationRecord
  belongs_to :user

  has_many :tag_relations, dependent: :destroy
  # has_many :tag_users, through: :tag_relations, source: :user, dependent: :destroy
  has_many :tags, through: :tag_relations

  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 20 }
  # 文字制限は変更の予定
  validates :content, presence: true, length: { maximum: 1000 }
end
