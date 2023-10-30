# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:report_test)

    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    assert_text 'ログインしました。'
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: '日報の一覧'
    assert_text 'タイトル'
    assert_text '日報'
    assert_text '作成者'
    assert_text '作成日'
  end

  test 'should create report' do
    visit reports_url
    click_on '日報の新規作成'

    fill_in 'タイトル', with: '日報のテスト2'
    fill_in '内容', with: 'テスト2です。'
    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text '日報のテスト2'
    assert_text 'テスト2です。'
    click_on '日報の一覧に戻る'
  end

  test 'should update Report' do
    visit report_url(@report)
    click_on 'この日報を編集', match: :first

    fill_in 'タイトル', with: '日報のテスト3'
    fill_in '内容', with: 'テスト3です。'
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text '日報のテスト3'
    assert_text 'テスト3です。'
    click_on '日報の一覧に戻る'
  end

  test 'should destroy Report' do
    visit report_url(@report)
    click_on 'この日報を削除', match: :first

    assert_text '日報が削除されました。'
  end
end
