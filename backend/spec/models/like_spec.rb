require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @my_article = FactoryBot.create(:article)
    @other_user_article = FactoryBot.create(:article4)
  end

  it '有効なファクトリである' do
    expect(@my_article).to be_valid
    expect(@other_user_article).to be_valid
  end

  it 'ユーザーIDが存在しない場合は、無効である' do
    like = Like.create(user_id: '', article_id: @other_user_article.id)
    like.valid?
    expect(like.errors.full_messages).to include('Userを入力してください')
  end

  it '記事IDが存在しない場合は、無効である' do
    like = Like.create(user_id: @my_article.user.id, article_id: '')
    like.valid?
    expect(like.errors.full_messages).to include('Articleを入力してください')
  end

  it 'ユーザー/記事IDどちらも存在すれば、有効である' do
    like = Like.create(user_id: @my_article.user.id, article_id: @other_user_article.id)
    like.valid?
    expect(like).to be_valid
  end

  it '同じ記事に2回いいねを押すと、重複エラーで無効になる' do
    Like.create(user_id: @my_article.user.id, article_id: @other_user_article.id)
    like = Like.create(user_id: @my_article.user.id, article_id: @other_user_article.id)
    like.valid?
    expect(like).to be_invalid
  end
end
