require "test_helper"

class EpisodesInterface < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    log_in_as(@user)
  end
end

class ImageUploadTest < EpisodesInterface

  test "画像の投稿フォームがあるかをテスト" do
    get root_path
    assert_select 'input[type= file ]'
  end

  test "投稿に成功した時に画像が表示されているかテスト" do
    # ixture_file_uploadというメソッドは、
    # fixtureで定義されたファイルをアップロードするメソッド
    img  = fixture_file_upload('kitten.jpg', 'image/jpeg')
    cont = "This episode really ties the room together."
    post episodes_path, params: { episode: { content: cont, image: img } }
    assert assigns(:episode).image.attached?
  end
end