class Tag < ApplicationRecord
  has_many :tag_relations, dependent: :destroy
  has_many :episodes, through: :tag_relations, dependent: :destroy
  # 一旦タグとエピソードだけの関連付けにして実装する
  # has_many :users, through: :tag_relations, dependent: :destroy
end
