# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'follow and unfollow' do
    alice = users(:alice)
    bob = users(:bob)
    assert_not alice.following?(bob)
    assert_not bob.followed_by?(alice)

    alice.follow(bob)
    assert alice.following?(bob)
    assert bob.followed_by?(alice)

    alice.unfollow(bob)
    assert_not alice.following?(bob)
    assert_not bob.followed_by?(alice)
  end

  test 'dupulicate follow should be ignored' do
    alice = users(:alice)
    bob = users(:bob)
    assert_difference('alice.followings.count', 1) do
      alice.follow(bob)
    end
    assert_no_difference('alice.followings.count') do
      alice.follow(bob)
    end
  end

  test 'name_or_email' do
    user = users(:alice)
    assert_equal 'alice@example.com', user.name_or_email

    user.name = 'Alice'
    assert_equal 'Alice', user.name_or_email
  end
end
