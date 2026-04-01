require 'rails_helper'

RSpec.describe '商品登録', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @category = FactoryBot.create(:category, user: @user)
  end

  context '商品登録ができるとき' do
    it 'ログインしたユーザーは商品登録ができる' do
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
      # 商品新規登録ページへ移動する
      visit new_item_path
      # 商品情報を入力する
      fill_in 'item_name', with: 'テスト商品'
      select @category.name, from: 'item_category_id'
      select 'gram', from: 'item_unit'
      # 新規登録ボタンを押すと商品モデルのカウントが1上がることを確認する
      expect do
        find('input[name="commit"]').click
        sleep 1
      end.to change { Item.count }.by(1)
      # トップページに遷移することを確認する
      expect(page).to have_current_path(root_path)
      # 商品一覧ページに先ほど登録した内容の商品が存在することを確認する
      visit items_path
      expect(page).to have_content('テスト商品')
    end
  end

  context '商品登録ができないとき' do
    it 'ログインしていないユーザーは商品登録画面に遷移しようとするとログイン画面にリダイレクトされる' do
      # 商品登録画面に遷移する
      visit new_item_path
      # ログインページに遷移することを確認する
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end
