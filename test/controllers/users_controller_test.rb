# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
  end

  test 'should redirect index when not signed in' do
    get users_url
    assert_redirected_to new_user_session_url
  end

  test 'should get index' do
    sign_in @user
    get users_url
    assert_response :success
  end

  test 'should redirect show when not signed in' do
    get user_url(@user)
    assert_redirected_to new_user_session_url
  end

  test 'should get show' do
    sign_in @user
    get user_url(users(:one))
    assert_response :success
  end
end
