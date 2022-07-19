require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @room = FactoryBot.create(:room)
  end

  it '有効なファクトリである' do
    expect(@user).to be_valid
    expect(@room).to be_valid
  end

  it '500文字を超えると、メッセージは無効である' do
    message = Message.create(
      user_id: @user.id,
      room_id: @room.id,
      content: 'a' * 501
    )
    expect(message.errors.full_messages).to include('メッセージ本文は500文字以内で入力してください')
  end

  it '500文字以内なら、メッセージが有効である' do
    message = Message.create(
      user_id: @user.id,
      room_id: @room.id,
      content: 'a' * 500
    )
    expect(message).to be_valid
  end

  it 'メッセージが空欄なら、無効である' do
    message = Message.create(
      user_id: @user.id,
      room_id: @room.id,
      content: nil
    )
    message.valid?
    expect(message.errors.full_messages).to include('メッセージ本文を入力してください')
  end
end
