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

  test "投稿者でないユーザーの削除リクエストに対してのテスト" do
    log_in_as(users(:michael))
    episode = episodes(:ants)
    assert_no_difference 'Episode.count' do
      delete episode_path(episode)
    end
    assert_response :see_other
    assert_redirected_to root_url
  end
end
