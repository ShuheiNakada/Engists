require 'rails_helper'

RSpec.describe 'Api::Comments', type: :request do
  describe 'GET /api/articles/:article_id/comments' do
    before do
      @user = FactoryBot.create(:user)
      @article = FactoryBot.create(:article4)
    end

    it '有効なファクトリ（ユーザー・記事）である' do
      expect(@user).to be_valid
      expect(@article).to be_valid
    end

    it '記事に対するコメントを全て取得する' do
      user = { email: 't_develop@app.com', password: 'pass1234' }
      auth_tokens = sign_in(user)

      get api_article_comments_path(@article.id), headers: auth_tokens
      expect(response).to have_http_status :ok
    end
  end

  describe 'POST /api/articles/:article_id/comments' do
    before do
      @user = FactoryBot.create(:user)
      @article = FactoryBot.create(:article4)
    end

    it '記事にコメントする' do
      user = { email: 't_develop@app.com', password: 'pass1234' }
      auth_tokens = sign_in(user)
      params = {
        comment: {
          category: '質問',
          title: 'フレームワークについて',
          content: '関西で就職を目指していますが、フレームワークはRailsよりLaravelを使って...'
        }
      }

      post api_article_comments_path(@article.id), params: params, headers: auth_tokens
      expect(response).to have_http_status :ok
    end
  end

  describe 'DELETE /api/articles/:article_id/comments/:id' do
    before do
      @user = FactoryBot.create(:user)
      @article = FactoryBot.create(:article, user_id: @user.id)
      @comment = FactoryBot.create(:comment, user_id: @user.id, article_id: @article.id)
    end

    it '有効なファクトリ(ユーザー・記事・コメント)である' do
      expect(@user).to be_valid
      expect(@article).to be_valid
      expect(@comment).to be_valid
    end

    it '記事に対するコメントを削除する' do
      user = { email: 't_develop@app.com', password: 'pass1234' }
      auth_tokens = sign_in(user)

      delete api_article_comment_path(id: @comment.id, article_id: @article.id), headers: auth_tokens
    end
  end
end
