class Episode < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  # 文字制限は変更の予定
  validates :content, presence: true, length: { maximum: 140 }
end
