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