require 'rails_helper'

RSpec.describe 'Items', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:category) { FactoryBot.create(:category, user: user) }
  let(:auth_headers) do
    {
      'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(
        ENV['BASIC_AUTH_USER'],
        ENV['BASIC_AUTH_PASSWORD']
      )
    }
  end

  before do
    sign_in user
  end

  describe 'GET /items' do
    it '正常にレスポンスを返す' do
      get items_path, headers: auth_headers
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /items/new' do
    it '正常にレスポンスを返す' do
      get new_item_path, headers: auth_headers
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /items' do
    context '有効なパラメータの場合' do
      let(:valid_params) { { item: { name: 'テスト商品', unit: 'gram', category_id: category.id } } }

      it '商品が登録される' do
        expect do
          post items_path, params: valid_params, headers: auth_headers
        end.to change(Item, :count).by(1)
      end

      it 'トップページにリダイレクトされる' do
        post items_path, params: valid_params, headers: auth_headers
        expect(response).to redirect_to(root_path)
      end
    end

    context '無効なパラメータの場合' do
      it '登録に失敗し、newテンプレートが再表示される' do
        post items_path, params: { item: { name: '' } }, headers: auth_headers
        expect(response).to have_http_status(422)
      end
    end
  end
end
