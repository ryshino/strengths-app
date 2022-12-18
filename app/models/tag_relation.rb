class TagRelation < ApplicationRecord
  belongs_to :user
  belongs_to :episode
  belongs_to :tag
end
