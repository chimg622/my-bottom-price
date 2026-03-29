require 'rails_helper'

RSpec.describe 'HomeController', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:auth_headers) do
    {
      'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(
        ENV['BASIC_AUTH_USER'],
        ENV['BASIC_AUTH_PASSWORD']
      )
    }
  end

  describe 'GET /' do
    context 'ログインしていない場合' do
      it '正常にレスポンスを返す' do
        get root_path, headers: auth_headers
        expect(response).to have_http_status(200)
      end
    end

    context 'ログインしている場合' do
      it '正常にレスポンスを返す' do
        sign_in user
        get root_path, headers: auth_headers
        expect(response).to have_http_status(200)
      end
    end
  end
end
