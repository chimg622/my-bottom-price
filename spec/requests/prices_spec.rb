require 'rails_helper'

RSpec.describe 'Prices', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:category) { FactoryBot.create(:category, user: user) }
  let(:item) { FactoryBot.create(:item, user: user, category: category) }
  let(:shop) { FactoryBot.create(:shop, user: user) }
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

  describe 'GET /prices' do
    it '正常にレスポンスを返す' do
      get prices_path, headers: auth_headers
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /prices' do
    context '有効なパラメータの場合' do
      let(:valid_params) do
        {
          price: {
            item_id: item.id,
            shop_id: shop.id,
            price: 500,
            quantity: 200,
            unit: 'gram'
          }
        }
      end

      it '価格情報が登録される' do
        expect do
          post prices_path, params: valid_params, headers: auth_headers
        end.to change(Price, :count).by(1)
      end

      it '商品一覧ページにリダイレクトされる' do
        post prices_path, params: valid_params, headers: auth_headers
        expect(response).to redirect_to(items_path)
      end
    end

    context '無効なパラメータの場合' do
      it '登録に失敗し、newテンプレートが再表示される' do
        post prices_path, params: { price: { price: '' } }, headers: auth_headers
        expect(response).to have_http_status(422)
      end
    end
  end
end
