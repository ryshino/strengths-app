require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "新規登録画面に遷移できるか検証" do
    get signup_path
    assert_response :success
  end

  test "indexアクションが正しくリダイレクトするか検証" do
    get users_path
    assert_redirected_to login_url
  end

  test "ログインしていないユーザーが編集しようとした時のテスト(edit)" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "ログインしていないユーザーが編集しようとした時のテスト(update)" do
    patch user_path(@user), params: { user: { name: @user.name,
                                              profile: @user.profile } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "admin属性の変更が禁止されていることをテストする" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: {
                                    user: { password:              "password",
                                            password_confirmation: "password",
                                            admin: true } }
    assert_not @other_user.reload.admin?
  end

  test "間違ったユーザーが編集しようとしたときのテスト(edit)" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "間違ったユーザーが編集しようとしたときのテスト(update)" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name,
                                              profile: @user.profile } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "ログインしていないユーザーが削除を実行した場合をテスト" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_response :see_other
    assert_redirected_to login_url
  end

  test "管理者権限のないユーザーが削除を実行した場合をテスト" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_response :see_other
    assert_redirected_to root_url
  end
end
