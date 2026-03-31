require 'rails_helper'

RSpec.describe '店舗登録', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context '店舗登録ができるとき' do
    it 'ログインしたユーザーは店舗登録ができる' do
      # トップページに遷移する
      visit "http://#{ENV['BASIC_AUTH_USER']}:#{ENV['BASIC_AUTH_PASSWORD']}@127.0.0.1:#{Capybara.current_session.server.port}#{root_path}"
      # トップページに新規登録ボタンがあることを確認
      expect(page).to have_content('ログイン')
      # ログインページへ移動する
      visit new_user_session_path
      # ユーザー情報を入力してログインする
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit"]').click
      expect(page).to have_current_path(root_path)
      # 店舗新規登録ページへ移動する
      visit new_shop_path
      # 店舗情報を入力する
      fill_in 'shop_name', with: 'テスト店舗'
      fill_in 'shop_address', with: 'テスト住所'
      # 新規登録ボタンを押すと店舗モデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
        sleep 1
      end.to change { Shop.count }.by(1)
      # トップページに遷移することを確認する
      expect(page).to have_current_path(root_path)
      # お店一覧ページに先ほど登録した内容の店舗が存在することを確認する
      visit shops_path
      expect(page).to have_content('テスト店舗')
    end
    it 'ログインしていないユーザーは店舗登録できない' do
      # 店舗登録画面に遷移する
      visit "http://#{ENV['BASIC_AUTH_USER']}:#{ENV['BASIC_AUTH_PASSWORD']}@127.0.0.1:#{Capybara.current_session.server.port}#{new_shop_path}"
      # ログインページに遷移することを確認する
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end
