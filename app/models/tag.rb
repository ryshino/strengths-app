class Tag < ApplicationRecord
  has_many :tag_relations, dependent: :destroy
  has_many :episodes, through: :tag_relations, dependent: :destroy
  has_many :users, through: :tag_relations, dependent: :destroy
end
