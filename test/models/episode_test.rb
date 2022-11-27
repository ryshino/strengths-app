require "test_helper"

class EpisodeTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @episode = @user.episodes.build(content: "テスト")
  end

  test "有効性のテスト" do
    assert @episode.valid?
  end

  test "user_idの存在性のバリデーションに対するテスト" do
    @episode.user_id = nil
    assert_not @episode.valid?
  end

  test "エピソードの存在性のバリデーションに対するテスト" do
    @episode.content = "   "
    assert_not @episode.valid?
  end

  test "エピソードの文字制限に対するテスト(文字制限は変更の予定)" do
    @episode.content = "a" * 141
    assert_not @episode.valid?
  end
end
