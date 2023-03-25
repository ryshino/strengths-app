class Tag < ApplicationRecord
  # dependent: :destroy をつけていたが、
  # タグは削除することを想定していないため
  # dependent: :destroyの記述を消した
  has_many :tag_relations
  has_many :episodes, through: :tag_relations
  has_many :users, through: :tag_relations

  default_scope -> { order(:id) }
end
