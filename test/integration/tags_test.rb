require "test_helper"

class Tags < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    log_in_as(@user)
  end
end

class TagsPagesTest < Tags
  # 投稿した後にちゃんとタグ付けがされているかのテストを書く
  # test "タグが表示されるかテスト" do
  #   get root_path
  #   assert_select "form input.form-check-input", count: 34
  # end
end