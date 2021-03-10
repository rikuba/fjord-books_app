# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should follow and unfollow a user' do
    one = users(:one)
    two = users(:two)
    assert_not one.following?(two)
    assert_not two.following?(one)

    one.follow(two)
    assert one.following?(two)
    assert_not two.following?(one)

    one.unfollow(two)
    assert_not one.following?(two)
    assert_not two.following?(one)
  end

  test 'should not follow themselves' do
    one = users(:one)
    assert_not one.following?(one)

    one.follow(one)
    assert_not one.following?(one)
  end
end
