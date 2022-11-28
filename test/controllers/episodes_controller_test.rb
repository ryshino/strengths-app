require "test_helper"

class EpisodesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @episode = episodes(:orange)
  end

  test "ログインせずに投稿のリクエストをした場合、リダイレクトされることをテスト" do
    assert_no_difference 'Episode.count' do
      post episodes_path, params: { episode: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "ログインせずに削除リクエストをした場合、リダイレクトされることをテスト" do
    assert_no_difference 'Episode.count' do
      delete episode_path(@episode)
    end
    assert_response :see_other
    assert_redirected_to login_url
  end
end
