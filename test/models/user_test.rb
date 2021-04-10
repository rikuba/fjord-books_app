# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @alice = create(:user, email: 'alice@example.com')
    @bob = create(:user, email: 'bob@example.com')
  end

  test 'follow and unfollow' do
    assert_not @alice.following?(@bob)
    assert_not @bob.followed_by?(@alice)

    @alice.follow(@bob)
    assert @alice.following?(@bob)
    assert @bob.followed_by?(@alice)

    @alice.unfollow(@bob)
    assert_not @alice.following?(@bob)
    assert_not @bob.followed_by?(@alice)
  end

  test 'dupulicate follow should be ignored' do
    assert_difference('@alice.followings.count', 1) do
      @alice.follow(@bob)
    end
    assert_no_difference('@alice.followings.count') do
      @alice.follow(@bob)
    end
  end

  test 'name_or_email' do
    assert_equal 'alice@example.com', @alice.name_or_email

    @alice.name = 'Alice'
    assert_equal 'Alice', @alice.name_or_email
  end
end
