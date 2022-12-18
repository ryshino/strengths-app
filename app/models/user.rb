class User < ApplicationRecord
  has_many :episodes, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                  foreign_key: "followed_id",
                                  dependent:   :destroy
  # source: によってfollowedをfollowingとして扱えるようになる
  has_many :following, through: :active_relationships, source: :followed
  # 「followers」の単数形「follower」で自動的に外部キーfollower_idを探索するため、
  # sourceがなくても良い
  has_many :followers, through: :passive_relationships, source: :follower
  
  has_many :tag_relations, dependent: :destroy
  # has_many :tag_episodes, through: :tag_relations, source: :episode, dependent: :destroy
  has_many :tags, through: :tag_relations, dependent: :destroy

  has_one_attached :profile_icon do |attachable|
    attachable.variant :display, resize_to_limit: [500, 500]
  end
  validates :profile_icon,   content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "無効な画像形式です" },
                      size:         { less_than: 5.megabytes,
                                      message:   "ファイルサイズが5MB以上あるため投稿できません" }
  
  validates :name,  presence: true, length: { maximum: 50 }
  validates :profile, presence: true, uniqueness: true
  validate :check_profile
  #:allow_nilオプションは、対象の値がnilの場合にバリデーションをスキップする
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  has_secure_password
  attr_accessor :remember_token

  def check_profile
    unless self.profile.start_with?("https://libecity.com/user_profile/")
      errors.add(:base, "そのプロフィールURLは使用できません")
    end
  end

  class << self
    # 渡された文字列のハッシュ値を返す
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # ランダムなトークンを返す
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    remember_digest
  end

  # セッションハイジャック防止のためにセッショントークンを返す
  # この記憶ダイジェストを再利用しているのは単に利便性のため
  # remember_digest が nil の場合は remember メソッドを実行する
  def session_token
    remember_digest || remember
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    # remember_digestの暗号化された文字列が 
    # 検証したい値(remember_token)から暗号化する文字列と一致するかを検証
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

  # フォローされているユーザーか、現在のユーザーに対応するuser_idを持つ
  # エピソードを返す
  # https://railsguides.jp/active_record_querying.html#or条件
  # https://rakuda3desu.net/rakudas-rails-tutorial14-3/
  def feed
    Episode.where(user: following).or(Episode.where(user_id: id))
  end

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user unless self == other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    following.delete(other_user)
  end

  # 現在のユーザーが他のユーザーをフォローしていればtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end  
end