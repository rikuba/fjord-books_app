# frozen_string_literal: true

require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]

  def log_in(email:, password:)
    visit root_url
    fill_in 'Eメール', with: email
    fill_in 'パスワード', with: password
    click_button 'ログイン'
  end
end
