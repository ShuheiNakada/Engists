require 'rails_helper'

RSpec.describe Article, type: :model do
  it '有効なファクトリである' do
    expect(FactoryBot.build(:article)).to be_valid
  end

  it 'ユーザー単位で重複したタイトル名は許可しない' do
    user = User.create(
      name: 'Shuhei Nakada',
      email: 'developman@mail.com',
      password: 'pass1234',
      password_confirmation: 'pass1234'
    )

    user.articles.create(
      title: 'バックエンドはRailsを選んで良いのか',
      content: 'プログラミング言語の選定として...'
    )

    new_article = user.articles.build(
      title: 'バックエンドはRailsを選んで良いのか',
      content: 'まずは学習リソースの多い...'
    )

    new_article.valid?
    expect(new_article.errors[:title]).to include('はすでに存在します')
  end

  it '２人のユーザーが同じタイトルを使うことは許可する' do
    user = User.create(
      name: 'Shuhei Nakada',
      email: 'develop@app.com',
      password: 'pass1234',
      password_confirmation: 'pass1234'
    )

    user.articles.create(
      title: 'バックエンドはRailsを選んで良いのか',
      content: 'プログラミング言語の選定として...'
    )

    other_user = User.create(
      name: 'Hidehira Tanaka',
      email: 'develop000@app.com',
      password: 'pass1234',
      password_confirmation: 'pass1234'
    )

    other_article = other_user.articles.build(
      title: 'バックエンドはRailsを選んで良いのか',
      content: '選定基準としては、まず...'
    )

    expect(other_article).to be_valid
  end
end
