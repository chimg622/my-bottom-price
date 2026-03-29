require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:auth_headers) do
    {
      'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(
        ENV['BASIC_AUTH_USER'],
        ENV['BASIC_AUTH_PASSWORD']
      )
    }
  end

  describe 'GET /users/sign_in' do
    it 'ログイン画面に正常にアクセスできる' do
      get new_user_session_path, headers: auth_headers
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /users/sign_up' do
    it '新規登録画面に正常にアクセスできる' do
      get new_user_registration_path, headers: auth_headers
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /users' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '正常にレスポンスを返す' do
        get users_index_path, headers: auth_headers
        expect(response).to have_http_status(200)
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトされる' do
        get users_index_path, headers: auth_headers
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
