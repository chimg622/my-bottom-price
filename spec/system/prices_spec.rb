require 'rails_helper'

RSpec.describe '価格登録', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @category = FactoryBot.create(:category, user: @user)
    @item = FactoryBot.create(:item, user: @user, category: @category)
    @shop = FactoryBot.create(:shop, user: @user)
  end

  context '価格登録ができるとき' do
    it 'ログインしたユーザーは価格登録ができる' do
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
      # 価格新規登録ページへ移動する
      visit new_price_path
      # 価格情報を入力する
      select @item.name, from: 'price_item_id'
      select @shop.name, from: 'price_shop_id'
      fill_in 'price_price', with: '1234'
      fill_in 'price_quantity', with: '567'
      select 'gram', from: 'price_unit'
      # 新規登録ボタンを押すと価格モデルのカウントが1上がることを確認する
      expect do
        find('input[name="commit"]').click
        sleep 1
      end.to change { Price.count }.by(1)
      # 商品一覧ページに遷移することを確認する
      expect(page).to have_current_path(items_path)
      # トップページに先ほど登録した内容の価格が存在することを確認する
      visit root_path
      expect(page).to have_content('1234')
    end
  end
  context '価格登録ができないとき' do
    it 'ログインしていないユーザーは価格登録画面に遷移しようとするとログイン画面にリダイレクトされる' do
      # 価格登録画面に遷移する
      visit new_price_path
      # ログインページに遷移することを確認する
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end
