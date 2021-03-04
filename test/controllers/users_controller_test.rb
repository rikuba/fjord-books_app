# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get users_url
    assert_response :success
  end

  test 'should get show' do
    get user_url(users(:one))
    assert_response :success
  end
end
