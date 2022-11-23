require "test_helper"

class UsersLogin < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end
end

class InvalidPasswordTest < UsersLogin

  test "ログイン画面が正しく表示されることを検証" do
    get login_path
    assert_template 'sessions/new'
  end

  test "URLが正しくてパスワードが誤っている場合をテストする" do
    post login_path, params: { session: { profile:    @user.profile,
                                          password: "invalid" } }
    assert_not is_logged_in?
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
end

class ValidLogin < UsersLogin

  def setup
    super
    post login_path, params: { session: { profile:    @user.profile,
                                          password: 'password' } }
  end
end

class ValidLoginTest < ValidLogin

  test "ユーザー詳細画面に移動" do
    assert is_logged_in?
    assert_redirected_to @user
  end

  test "ログイン後のリンクの表示が正しいかテスト" do
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end
end

class Logout < ValidLogin

  def setup
    super
    delete logout_path
  end
end

class LogoutTest < Logout

  test "ログアウトが行えているかテスト" do
    assert_not is_logged_in?
    assert_response :see_other
    assert_redirected_to root_url
  end

  test "2番目のウィンドウでユーザーをログアウトするテスト" do
    delete logout_path
    assert_redirected_to root_url
  end

  test "ログアウト後のリンクの表示が正しいかテスト" do
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
end

class RememberingTest < UsersLogin
#［remember me］チェックボックスのテスト

  test "ログインを記憶する場合" do
    log_in_as(@user, remember_me: '1')
    assert_equal cookies['remember_token'], assigns(:user).remember_token
  end

  test "ログインを記憶しない場合" do
    # Cookieを保存してログイン
    log_in_as(@user, remember_me: '1')
    # Cookieが削除されていることを検証してからログイン
    log_in_as(@user, remember_me: '0')
    assert cookies[:remember_token].blank?
  end
end
