# メインのサンプルユーザーを1人作成する
User.create!(name:  "Example User",
  profile: "https://libecity.com/user_profile/test",
  password:              "foobar",
  password_confirmation: "foobar",
  admin: true)

# 追加のユーザーをまとめて生成する
99.times do |n|
name  = Faker::Name.name
profile = "https://libecity.com/user_profile/test#{n+1}"
password = "password"
User.create!(name:  name,
    profile: profile,
    password:              password,
    password_confirmation: password)
end

# ユーザーの一部を対象にマイクロポストを生成する
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.episodes.create!(content: content) }
end

# ユーザーフォローのリレーションシップを作成する
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }