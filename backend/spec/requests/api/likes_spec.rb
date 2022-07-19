require 'rails_helper'

RSpec.describe 'Api::Likes', type: :request do
  describe 'POST /api/likes' do
    before do
      @user = FactoryBot.create(:user)
      @other_user_article = FactoryBot.create(:article4)
    end

    it '有効なファクトリである' do
      expect(@user).to be_valid
      expect(@other_user_article).to be_valid
    end

    it '記事に対して、いいねをする' do
      user = { email: 't_develop@app.com', password: 'pass1234' }
      auth_token = sign_in(user)

      post api_likes_path(id: @other_user_article.id), headers: auth_token
      expect(response).to have_http_status :ok
    end
  end

  describe 'DELETE /api/likes/:id' do
    before do
      @user = FactoryBot.create(:user)
      @other_user_article = FactoryBot.create(:article4)
    end

    it '記事に対して、いいねを取り消す' do
      user = { email: 't_develop@app.com', password: 'pass1234' }
      auth_token = sign_in(user)

      delete api_like_path(id: @other_user_article.id), headers: auth_token
      expect(response).to have_http_status :ok
    end
  end

  describe 'GET /api/likes' do
    before do
      @user = FactoryBot.create(:user)
      @other_user_article = FactoryBot.create(:article4)
    end

    it 'いいね数、自分の記事であるか、既にいいねしているか、の情報を取得する' do
      user = { email: 't_develop@app.com', password: 'pass1234' }
      auth_token = sign_in(user)

      get api_likes_path(id: @other_user_article.id), headers: auth_token
      expect(response).to have_http_status :ok
    end
  end
end
