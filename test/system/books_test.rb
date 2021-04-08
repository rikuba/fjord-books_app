# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    @book = create(:book, title: 'プロを目指す人のためのRuby入門', memo: '為になる', author: 'jnchito')

    log_in(email: @user.email, password: @user.password)
  end

  test 'visiting the index' do
    visit books_url

    assert_selector 'h1', text: '本'
    assert_text @book.title
  end

  test 'creating a Book' do
    visit books_url
    click_on '新規作成'

    fill_in 'タイトル', with: 'Ruby超入門'
    fill_in 'メモ', with: 'わかりやすい'
    fill_in '著者', with: 'igaiga'
    click_on '登録する'

    assert_text '本が作成されました。'
    assert_text 'Ruby超入門'
    assert_text 'わかりやすい'
    assert_text 'igaiga'
  end

  test 'updating a Book' do
    visit books_url
    click_on '編集'

    fill_in 'メモ', with: 'たのしい'
    click_on '更新する'

    assert_text '本が更新されました。'
    assert_text 'たのしい'
  end

  test 'destroying a Book' do
    visit books_url
    assert_text @book.title

    page.accept_confirm do
      click_on '削除'
    end

    assert_text '本が削除されました。'
    assert_no_text @book.title
  end
end
