require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "リンクが正しく表示されているかテスト" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", signup_path
    assert_select "a[href=?]", "https://qiita.com/yatchi_323/private/968f9121139472fceffe", "使い方を見る"
    get login_path
    assert_select "title", full_title("ログイン")
    get signup_path
    assert_select "title", full_title("新規登録")
  end

  test "ログイン後、リンクが正しく表示されているかテスト" do
    log_in_as(@user)
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", episodes_path
    assert_select "a[href=?]", new_episode_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", "https://qiita.com/yatchi_323/private/968f9121139472fceffe", "使い方を見る"
  end
end