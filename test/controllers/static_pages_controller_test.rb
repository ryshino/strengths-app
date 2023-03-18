require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "StrengthsApp"
  end

  test "正常に動作することをテスト" do
    get root_url
    assert_response :success
  end
  
  test "タイトルが正しく表示されることをテスト" do
    get root_path
    assert_response :success
    assert_select "title", "StrengthsApp"
  end
end
