class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 50 }
  validates :profile, presence: true, uniqueness: true
  validate :check_profile
  validates :password, presence: true, length: { minimum: 6 }

  has_secure_password

  def check_profile
    unless self.profile.start_with?("https://libecity.com/user_profile/")
      errors.add(:base, "そのプロフィールURLは使用できません")
    end
  end
end