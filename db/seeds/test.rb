# メインのサンプルユーザーを1人作成する
User.create!(name:  "Example User",
  profile: "https://libecity.com/user_profile/test",
  password:              "foobar",
  password_confirmation: "foobar",
  admin: true)

# 追加のユーザーをまとめて生成する
99.times do |n|
name  = Gimei.unique.name.kanji
profile = "https://libecity.com/user_profile/test#{n+1}"
password = "password"
User.create!(name:  name,
    profile: profile,
    password:              password,
    password_confirmation: password)
end

# 最初の6人だけにエピソードを追加
users = User.order(:created_at).take(6)
50.times do
  title = Faker::Games::Pokemon.name
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.episodes.create!(title: title, content: content) }
end

# ユーザーフォローのリレーションシップを作成する
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

Tag.create([
  {name: '達成欲'},
  {name: 'アレンジ'},
  {name: '信念'},
  {name: '公平性'},
  {name: '慎重さ'},
  {name: '規律性'},
  {name: '目標志向'},
  {name: '責任感'},
  {name: '回復志向'},
  {name: '活発性'},
  {name: '指令性'},
  {name: 'コミュニケーション'},
  {name: '競争性'},
  {name: '最上志向'},
  {name: '自己確信'},
  {name: '自我'},
  {name: '社交性'},
  {name: '適応性'},
  {name: '運命思考'},
  {name: '成長促進'},
  {name: '共感性'},
  {name: '調和性'},
  {name: '包含'},
  {name: '個別化'},
  {name: 'ポジティブ'},
  {name: '親密性'},
  {name: '分析思考'},
  {name: '原点思考'},
  {name: '未来志向'},
  {name: '着想'},
  {name: '収集心'},
  {name: '内省'},
  {name: '学習欲'},
  {name: '戦略性'}
])
