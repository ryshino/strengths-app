require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin     = users(:michael)
    @non_admin = users(:archer)
  end

  test "削除リンクとユーザー削除に対する統合テスト" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    first_page_of_users = User.page(1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      # 削除対象のユーザーが管理者の場合はテストをスキップする
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: '削除'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
      assert_response :see_other
      assert_redirected_to users_url
    end
  end

  test "管理者でない場合、削除リンクがないことをテスト" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: '削除', count: 0
  end
end