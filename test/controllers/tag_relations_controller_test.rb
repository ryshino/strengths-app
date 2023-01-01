require "test_helper"

class TagRelationsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get tag_relations_create_url
    assert_response :success
  end

  test "should get update" do
    get tag_relations_update_url
    assert_response :success
  end
end
