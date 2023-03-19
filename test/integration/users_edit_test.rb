require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "編集の失敗に対するテスト" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                              profile: "invalid/libecity.com/user_profile/test",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'users/edit'
    assert_select "div.alert"
  end

  test "フレンドリーフォワーディングのテスト" do
    get edit_user_path(@user)
    assert_equal session[:forwarding_url], "http://www.example.com" + edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    assert_nil session[:forwarding_url]
    name  = "Foo Bar"
    profile = "https://libecity.com/user_profile/test"
    patch user_path(@user), params: { user: { name:  name,
                                              profile: profile,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal profile, @user.profile
  end
end
