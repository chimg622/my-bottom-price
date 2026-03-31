require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに遷移する
      visit "http://#{ENV['BASIC_AUTH_USER']}:#{ENV['BASIC_AUTH_PASSWORD']}@127.0.0.1:#{Capybara.current_session.server.port}#{root_path}"
      # トップページに新規登録ボタンがあることを確認
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user_name', with: 'テスト'
      fill_in 'user_email', with: 'test@example.com'
      fill_in 'user_password', with: 'password123'
      fill_in 'user_password_confirmation', with: 'password123'
      # 新規登録ボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
        sleep 1
      end.to change { User.count }.by(1)
      # トップページに遷移することを確認する
      expect(page).to have_current_path(root_path)
      # サインアップ・ログインボタンが表示されていないことを確認
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
      # マイページに遷移する
      visit user_path
      # ログアウトボタンが表示されることを確認
      expect(page).to have_content('ログアウト')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      visit "http://#{ENV['BASIC_AUTH_USER']}:#{ENV['BASIC_AUTH_PASSWORD']}@127.0.0.1:#{Capybara.current_session.server.port}#{root_path}"
      # トップページに新規登録ボタンがあることを確認
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user_name', with: ''
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      fill_in 'user_password_confirmation', with: ''
      # 新規登録ボタンを押してもユーザーモデルのカウントが上がらないことを確認する
      expect  do
        find('input[name="commit"]').click
        sleep 1
      end.to change { User.count }.by(0)
      # 新規登録ページに遷移することを確認する
      expect(page).to have_current_path(new_user_registration_path)
    end
  end
end
