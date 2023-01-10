require "test_helper"

class EpisodesInterface < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @tag = tags(:tag_1)
    log_in_as(@user)
  end
end

class EpisodesInterfaceTest < EpisodesInterface

  test "ページネーションがあるかテスト" do
    get root_path
    assert_select 'div.pagination'
  end

  test "エラーを表示し、無効な送信に対してエピソードを作成しているかテスト" do
    assert_no_difference 'Episode.count' do
      post episodes_path, params: { episode: { content: "", tag_ids: [@tag.id] } }
    end
    assert_select 'div#error_explanation'
    assert_select 'a[href=?]', '/?page=2'  # 正しいページネーションリンク
  end

  test "エピソードが作成されているかテスト" do
    title = "sample title"
    content = "This episode really ties the room together"
    assert_difference 'Episode.count', 1 do
      post episodes_path, params: { episode: { title: title, content: content, tag_ids: [@tag.id] } }
    end
    assert_redirected_to episodes_path
    follow_redirect!
    # 投稿したエピソードが存在するか確認している
    assert_match title, response.body
    assert_match content, response.body
    assert_match @tag.name, response.body
  end

  test "自分の投稿に対して削除リンクがあるかテスト" do
    # テキストではusers_pathだったけど、user_pathに変更
    get user_path(@user)
    assert_select 'a', text: '削除'
  end

  test "自分の投稿を削除できるかテストe" do
    first_episode = @user.episodes.paginate(page: 1).first
    assert_difference 'Episode.count', -1 do
      delete episode_path(first_episode)
    end
  end

  test "他のユーザーの投稿に対しては削除リンクが存在しないことをテスト" do
    get user_path(users(:archer))
    assert_select 'a', { text: '削除', count: 0 }
  end
end

class EpisodeSidebarTest < EpisodesInterface

  test "正しいエピソード数が表示されているかテスト" do
    get root_path
    assert_match "#{ @user.episodes.count } episodes", response.body
  end

  test "投稿数が0の時適切な形で表示しているかテスト" do
    log_in_as(users(:malory))
    get root_path
    assert_match "0 episodes", response.body
  end

  test "投稿数が1の時適切な形で表示しているかテスト" do
    log_in_as(users(:lana))
    get root_path
    assert_match "1 episode", response.body
  end
end
