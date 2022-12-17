require "test_helper"

class EpisodesInterface < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
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
      post episodes_path, params: { episode: { content: "" } }
    end
    assert_select 'div#error_explanation'
    assert_select 'a[href=?]', '/?page=2'  # 正しいページネーションリンク
  end

  test "エピソードが作成されているかテスト" do
    content = "This episode really ties the room together"
    assert_difference 'Episode.count', 1 do
      post episodes_path, params: { episode: { content: content } }
    end
    assert_redirected_to episodes_path
    follow_redirect!
    # 投稿したエピソードが存在するか確認している
    assert_match content, response.body
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

class ImageUploadTest < EpisodesInterface

  test "画像の投稿フォームがあるかテスト" do
    get root_path
    assert_select 'input[type= file ]'
  end

  test "投稿に成功した時に画像が表示されているかテスト" do
    cont = "This episode really ties the room together."
    img  = fixture_file_upload('kitten.jpg', 'image/jpeg')
    post episodes_path, params: { episode: { content: cont, image: img } }
    assert assigns[:episode].image.attached?
  end
end
