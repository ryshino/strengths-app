require "test_helper"

class EpisodesShowTest < ActionDispatch::IntegrationTest
  def setup
    img  = fixture_file_upload('kitten.jpg', 'image/jpeg')
    @user = users(:michael)
    @user.profile_icon.attach(img)
    @user.strength_image.attach(img)
    @tag_1 = tags(:tag_1)
    @tag_2 = tags(:tag_2)
    @tag_3 = tags(:tag_3)
    @episode = @user.episodes.find_by(title: "most_recent title")
    log_in_as(@user)
  end

  test "エピソード詳細画面に対するテスト" do
    get episode_path(@episode)
    assert_template 'episodes/show'
    assert_select 'title', "エピソード | StrengthsApp"
    assert_select 'p.card-title', "most_recent title"
    assert_match @episode.title, response.body
    assert_match @episode.content, response.body
    assert_match @user.name, response.body
    assert_match @user.profile, response.body
    assert @user.profile_icon.attached?
    assert @user.strength_image.attached?
    @episode.tags.each do |tag|
      assert_match tag.name, response.body
    end
  end
end
