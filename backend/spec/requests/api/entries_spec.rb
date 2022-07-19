require 'rails_helper'

RSpec.describe 'Api::Entries', type: :request do
  describe 'GET /api/entries' do
    before do
      @user = FactoryBot.create(:user)
    end

    it '有効なファクトリである' do
      expect(@user).to be_valid
    end

    it '自分がどのDMルームにエントリーしているかの情報を取得する' do
      user = { email: 't_develop@app.com', password: 'pass1234' }
      auth_tokens = sign_in(user)

      get api_entries_path, headers: auth_tokens
      expect(response).to have_http_status :ok
    end
  end
end
