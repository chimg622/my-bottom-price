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

RSpec.describe 'ユーザー編集機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ユーザー編集ができるとき' do
    it 'ログインしたユーザーはユーザー編集ができる' do
      # トップページに遷移する
      visit "http://#{ENV['BASIC_AUTH_USER']}:#{ENV['BASIC_AUTH_PASSWORD']}@127.0.0.1:#{Capybara.current_session.server.port}#{root_path}"
      # トップページにログインボタンがあることを確認
      expect(page).to have_content('ログイン')
      # ログインページへ移動する
      visit new_user_session_path
      # ユーザー情報を入力してログインする
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit"]').click
      expect(page).to have_current_path(root_path)
      # マイページに遷移する
      visit user_path
      # 編集ボタンが表示されることを確認する
      expect(page).to have_content('プロフィールを編集')
      # 編集ページに遷移する
      visit edit_user_registration_path
      # 新しい名前とメールアドレス、現在のパスワードを入力して、アカウント更新ボタンを押す
      fill_in 'user_name', with: 'テストユーザー'
      fill_in 'user_email', with: 'test@example.com'
      fill_in 'user_password', with: 'password123'
      fill_in 'user_password_confirmation', with: 'password123'
      fill_in 'user_current_password', with: @user.password
      find('input[name="commit"]').click
      # トップページに遷移することを確認する
      expect(page).to have_current_path(root_path)
      # トップページに新しい名前が存在することを確認する
      expect(page).to have_content('テストユーザー')
    end
  end
  context 'ユーザー編集ができないとき' do
    it 'ログインしていないユーザーはユーザー編集画面に遷移しようとするとログイン画面にリダイレクトされる' do
      # 編集ページに遷移する
      visit edit_user_registration_path
      # ログインページに遷移することを確認する
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end
