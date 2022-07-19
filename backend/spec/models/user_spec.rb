require 'rails_helper'

RSpec.describe User, type: :model do
  it '有効なファクトリである' do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it 'ユーザー名、メールアドレス、パスワード、再確認用パスワードの値が有効である' do
    user = User.new(
      name: 'Nakada Shuhei',
      email: 'develop@app.com',
      password: 'pass1234',
      password_confirmation: 'pass1234'
    )
    expect(user).to be_valid
  end

  it 'ユーザー名がなければ、無効である' do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include('を入力してください')
  end

  it 'メールアドレスがなければ、無効である' do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include('を入力してください')
  end

  it 'パスワードがなければ、無効である' do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include('を入力してください')
  end

  it '重複したメールアドレスは無効である' do
    FactoryBot.create(:user, email: 'same@mail.com')
    user = FactoryBot.build(:user, email: 'same@mail.com')
    user.valid?
    expect(user.errors[:email]).to include('はすでに存在します')
  end
end
