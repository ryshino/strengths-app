require "test_helper"

class EpisodesInterface < ActionDispatch::IntegrationTest
  def setup
    @user = users(:archer)
    @tag_1 = tags(:tag_1)
    @tag_2 = tags(:tag_2)
    @tag_3 = tags(:tag_3)
    log_in_as(@user)
  end
end

class EpisodesInterfaceTest < EpisodesInterface

  test "無効な送信に対してエピソードを作成せず、エラーを表示しているかテスト" do
    assert_no_difference 'Episode.count' do
      post episodes_path, params: { episode: { title: "", content: "", tag_ids: [@tag_1.id] } }
    end
    assert_select 'div#error_explanation'
  end

  test "タグが2つ以上選択されていた場合、投稿できないことをテスト" do
    post episodes_path, params: { episode: { title: "test", body: "test", tag_ids: [@tag_1.id, @tag_2.id, @tag_3.id] } }
    assert_response :unprocessable_entity
    assert_select '.alert', text: "選択できる資質は2つまでです"
  end

  test "エピソードが作成されているかテスト" do
    title = "sample title"
    content = "This episode really ties the room together"
    assert_difference 'Episode.count', 1 do
      post episodes_path, params: { episode: { title: title, content: content, tag_ids: [@tag_1.id] } }
    end
    assert_redirected_to episodes_path
    follow_redirect!
    # 投稿したエピソードが存在するか確認している
    assert_match title, response.body
    assert_match content, response.body
    assert_match @tag_1.name, response.body
  end

  test "自分の投稿に対して削除リンクがあるかテスト" do
    # テキストではusers_pathだったけど、user_pathに変更
    get user_path(@user)
    assert_select 'a', text: '削除'
  end

  test "自分の投稿を削除できるかテストe" do
    first_episode = @user.episodes.page(1).first
    assert_difference 'Episode.count', -1 do
      delete episode_path(first_episode)
    end
  end

  test "他のユーザーの投稿に対しては削除リンクが存在しないことをテスト" do
    get user_path(users(:lana))
    assert_select 'a', { text: '削除', count: 0 }
  end
end