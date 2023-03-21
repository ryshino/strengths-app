require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "無効なユーザー登録に対するテスト " do
    img  = fixture_file_upload('kitten.jpg', 'image/jpeg')
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                        profile: "libecity.com/user_profile/test",
                                        profile_icon: img,
                                        password:              "foo",
                                        password_confirmation: "bar" } }
    end
    assert_response :unprocessable_entity
    assert_template 'users/new'

    #エラーメッセージが存在するか確認
    assert_select 'div#error_explanation'
    assert_select 'div.alert-error'
  end

  test "有効なユーザー登録に対するテスト" do
    img  = fixture_file_upload('kitten.jpg', 'image/jpeg')
    get signup_path
    assert_select 'input[type= file]'
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "テスト",
                                        profile: "https://libecity.com/user_profile/test",
                                        profile_icon: img,
                                        strength_image: img,
                                        password:              "password",
                                        password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    assert is_logged_in?
    assert assigns[:user].profile_icon.attached?
    assert assigns[:user].strength_image.attached?
  end
end