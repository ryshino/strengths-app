require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "メールアドレスが正しくてパスワードが誤っている場合をテストする" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { profile: "https://libecity.com/user_profile/MichaelExample", password: "invalid" } }
    assert_response :unprocessable_entity
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information" do
    post login_path, params: { session: { profile:    @user.profile,
                                          password: 'password' } }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end
end
