class Episode < ApplicationRecord
  belongs_to :user

  has_many :tag_relations, dependent: :destroy
  # has_many :tag_users, through: :tag_relations, source: :user, dependent: :destroy
  has_many :tags, through: :tag_relations, dependent: :destroy
  
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [500, 500]
  end
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  # 文字制限は変更の予定
  validates :content, presence: true, length: { maximum: 1000 }
  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "無効な画像形式です" },
                      size:         { less_than: 5.megabytes,
                                      message:   "ファイルサイズが5MB以上あるため投稿できません" }
end
