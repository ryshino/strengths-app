require "test_helper"

class FollowingTest < ActionDispatch::IntegrationTest
  def setup
    @user  = users(:michael)
    log_in_as(@user)
  end
end

class FollowPagesTest < FollowingTest

  test "フォローページのテスト" do
    get following_user_path(@user)
    assert_response :unprocessable_entity
    # each文が1度も実行されないままテストがパスするのを防ぐため記述
    assert_not @user.following.empty?
    assert_match @user.following.count.to_s, response.body
    @user.following.each do |user|
      assert_select "a[href=?]", user_path(user)
    end
  end

  test "フォロワーページのテスト" do
    get followers_user_path(@user)
    assert_response :unprocessable_entity
    # each文が1度も実行されないままテストがパスするのを防ぐため記述
    assert_not @user.followers.empty?
    assert_match @user.followers.count.to_s, response.body
    @user.followers.each do |user|
      assert_select "a[href=?]", user_path(user)
    end
  end
end
