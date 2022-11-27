class Episode < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  # 文字制限は変更の予定
  validates :content, presence: true, length: { maximum: 140 }
end
