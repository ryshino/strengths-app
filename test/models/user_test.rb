require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "テスト", profile: "https://libecity.com/user_profile/test",
                    password: "foobar", password_confirmation: "foobar")
  end

  test "有効なユーザーかどうかをテスト" do
    assert @user.valid?
  end

  test "name属性のバリデーションに対するテスト" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "profile属性のバリデーションに関するテスト" do
    @user.profile = "     "
    assert_not @user.valid?
  end

  test "名前の長さをテスト" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  #リベのプロフィールでは検証の必要がないためコメントアウト
  # test "profile should not be too long" do
  #   @user.profile = "a" * 244 + "@example.com"
  #   assert_not @user.valid?
  # end

  #eachにする必要はないが勉強のためあえて%wを使用
  test "有効なURLをテスト" do
    valid_urls = %w[https://libecity.com/user_profile/test]
    valid_urls.each do |valid_url|
      @user.profile = valid_url
      assert @user.valid?, "#{valid_url.inspect} は有効なURLです"
    end
  end

  test "無効なプロフィールをテスト" do
    invalid_urls  = %w[libecity.com/user_profile/test user_profile/test]
    invalid_urls.each do |invalid_url|
      @user.profile = invalid_url
      assert_not @user.valid?, "#{invalid_url.inspect} は無効なURLです"
    end
  end

  test "重複するプロフィールのテスト" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "パスワードが空の場合のバリデーションの検証" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "パスワードが6文字以下の場合のバリデーションの検証" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "ダイジェストが存在しない場合のauthenticated?のテスト" do
    assert_not @user.authenticated?('')
  end

  test "ユーザーを削除した時、それに紐づくエピソードも削除されるかテスト" do
    @user.save
    @user.episodes.create!(title: "title", content: "Lorem ipsum")
    assert_difference 'Episode.count', -1 do
      @user.destroy 
    end
  end

  test "following関連のメソッドをテストする" do
    michael = users(:michael)
    archer  = users(:archer)
    assert_not michael.following?(archer)
    michael.follow(archer)
    assert michael.following?(archer)
    assert archer.followers.include?(michael)
    michael.unfollow(archer)
    assert_not michael.following?(archer)
    # ユーザーは自分自身をフォローできない
    michael.follow(michael)
    assert_not michael.following?(michael)
  end

  test "ステータスフィードのテスト" do
    michael = users(:michael)
    archer  = users(:archer)
    lana    = users(:lana)
    # フォローしているユーザーの投稿を確認
    lana.episodes.each do |post_following|
      assert michael.feed.include?(post_following)
    end
    # フォロワーがいるユーザー自身の投稿を確認
    michael.episodes.each do |post_self|
      assert michael.feed.include?(post_self)
    end
    # フォローしていないユーザーの投稿を確認
    archer.episodes.each do |post_unfollowed|
      assert_not michael.feed.include?(post_unfollowed)
    end
  end
end
