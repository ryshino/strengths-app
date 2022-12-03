require "test_helper"

class RelationshipTest < ActiveSupport::TestCase
  def setup
    @relationship = Relationship.new(follower_id: users(:michael).id,
                                     followed_id: users(:archer).id)
  end

  test "バリデーションのテスト" do
    assert @relationship.valid?
  end

  test "follower_idがnilの時、バリデーションが動作することをテスト" do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test "followed_idがnilの時、バリデーションが動作することをテスト" do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end
end
