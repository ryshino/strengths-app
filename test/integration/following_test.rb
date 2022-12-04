require "test_helper"

class Following < ActionDispatch::IntegrationTest
  def setup
    @user  = users(:michael)
    @other = users(:archer)
    log_in_as(@user)
  end
end

class FollowPagesTest < Following

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

  test "episode.contentをエスケープして、投稿が表示されることをテスト" do
    get root_path
    @user.feed.paginate(page: 1).each do |episode|
      # CGI.escapeHTMLを使用しているのは、
      # エスケープしないと改行文字や記号が特殊文字で出力されるため。
      assert_match CGI.escapeHTML(episode.content), response.body
    end
  end
end

class FollowTest < Following

  test "標準のフォローリクエストをテスト" do
    assert_difference "@user.following.count", 1 do
      post relationships_path, params: { followed_id: @other.id }
    end
    assert_redirected_to @other
  end

  test "Hotwireのフォローリクエストをテスト" do
    assert_difference "@user.following.count", 1 do
      post relationships_path(format: :turbo_stream),
            params: { followed_id: @other.id }
    end
  end
end

class Unfollow < Following

  def setup
    super
    @user.follow(@other)
    @relationship = @user.active_relationships.find_by(followed_id: @other.id)
  end
end

class UnfollowTest < Unfollow

  test "標準のフォロー解除リクエストをテスト" do
    assert_difference "@user.following.count", -1 do
      delete relationship_path(@relationship)
    end
    assert_response :see_other
    assert_redirected_to @other
  end

  test "Hotwireのフォロー解除リクエストをテスト" do
    assert_difference "@user.following.count", -1 do
      delete relationship_path(@relationship, format: :turbo_stream)
    end
  end
end
