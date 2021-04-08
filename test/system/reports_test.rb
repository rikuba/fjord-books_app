# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    @report = @user.reports.create(title: 'TDDの基本', content: 'テストファーストを身に付けました。')

    log_in(email: @user.email, password: @user.password)
  end

  test 'visiting the index' do
    visit reports_url

    assert_selector 'h1', text: '日報'
    assert_text @report.title
  end

  test 'creating a Report' do
    visit reports_url
    click_on '新規作成'

    fill_in 'タイトル', with: 'テスト技法'
    fill_in '内容', with: 'ユニットテストを書きました。'
    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text 'テスト技法'
    assert_text 'ユニットテストを書きました。'
  end

  test 'updating a Report' do
    visit reports_url
    click_on '編集'

    fill_in 'タイトル', with: 'テスト技法 2日目'
    fill_in '内容', with: 'システムテストを修正しました。'
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text 'テスト技法 2日目'
    assert_text 'システムテストを修正しました。'
  end

  test 'destroying a Report' do
    visit reports_url
    assert_text @report.title

    page.accept_confirm do
      click_on '削除'
    end

    assert_text '日報が削除されました。'
    assert_no_text @report.title
  end
end
