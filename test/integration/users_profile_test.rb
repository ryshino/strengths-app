require "test_helper"

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  test "ユーザー詳細画面に対するテスト" do
    log_in_as(@user)
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_match @user.followers.count.to_s, response.body
    assert_match @user.following.count.to_s, response.body
    @user.episodes.page(1).each do |episode|
      assert_match episode.title, response.body
      assert_match episode.content, response.body
    end
  end
end
