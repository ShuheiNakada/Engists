require 'rails_helper'

RSpec.describe Comment, type: :model do
  it '有効なファクトリである' do
    expect(FactoryBot.build(:comment)).to be_valid
  end

  it 'カテゴリーがなければ、無効である' do
    comment = FactoryBot.build(:comment, category: nil)
    comment.valid?
    expect(comment.errors.full_messages).to include('カテゴリーを入力してください')
  end

  it 'タイトルがなければ、無効である' do
    comment = FactoryBot.build(:comment, title: nil)
    comment.valid?
    expect(comment.errors.full_messages).to include('タイトルを入力してください')
  end

  it 'タイトルの文字数が31文字以上であれば、無効である' do
    comment = FactoryBot.build(:comment, title: 'RailsをRailsチュートリアルで学習してアウトプットした記録.....')
    comment.valid?
    expect(comment.errors.full_messages).to include('タイトルは30文字以内で入力してください')
  end

  it 'コメント本文がなければ、無効である' do
    comment = FactoryBot.build(:comment, content: nil)
    comment.valid?
    expect(comment.errors.full_messages).to include('コメント本文を入力してください')
  end
end
