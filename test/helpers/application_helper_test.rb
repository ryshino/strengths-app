require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal "StrengthsApp", full_title
    assert_equal "Help | StrengthsApp", full_title("Help")
  end
end