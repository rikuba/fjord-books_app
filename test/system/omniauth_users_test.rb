# frozen_string_literal: true

require 'application_system_test_case'

class OmniauthUsersTest < ApplicationSystemTestCase
  setup do
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
      Faker::Omniauth.github(name: 'Carol', email: 'carol@example.com')
    )
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
  end

  test 'log in with GitHub account' do
    visit root_url
    click_on 'GitHubでログイン'
    assert_text 'GitHub アカウントによる認証に成功しました。'
    assert_text 'carol@example.com としてログイン中'
  end
end
