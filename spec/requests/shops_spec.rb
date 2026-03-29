require 'rails_helper'

RSpec.describe 'Shops', type: :request do
  let(:user) { FactoryBot.create(:user) }
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
  describe 'GET /shops' do
    it '正常にレスポンスを返す' do
      get shops_path, headers: auth_headers
      expect(response).to have_http_status(200)
    end
  end
  describe 'GET /shops/new' do
    it '正常にレスポンスを返す' do
      get new_shop_path, headers: auth_headers
      expect(response).to have_http_status(200)
    end
  end
  describe 'POST /shops' do
    context '有効なパラメータの場合' do
      let(:valid_params) { { shop: { name: 'テスト店舗', address: 'テスト住所' } } }

      it '店舗が登録される' do
        expect do
          post shops_path, params: valid_params, headers: auth_headers
        end.to change(Shop, :count).by(1)
      end

      it 'トップページにリダイレクトされる' do
        post shops_path, params: valid_params, headers: auth_headers
        expect(response).to redirect_to(root_path)
      end
    end

    context '無効なパラメータの場合' do
      it '登録に失敗し、newテンプレートが再表示される' do
        post shops_path, params: { shop: { name: '' } }, headers: auth_headers
        expect(response).to have_http_status(422)
      end
    end
  end
end
