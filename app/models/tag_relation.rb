class TagRelation < ApplicationRecord
  # 一旦タグとエピソードだけの関連付けにして実装する
  # belongs_to :user
  belongs_to :episode
  belongs_to :tag
end
