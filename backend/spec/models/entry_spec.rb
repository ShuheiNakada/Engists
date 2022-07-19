require 'rails_helper'

RSpec.describe Entry, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @room = FactoryBot.create(:room)
  end

  it '有効なファクトリである' do
    expect(@user).to be_valid
    expect(@room).to be_valid
  end

  it 'ユーザー情報がなければ、エントリーは登録できない' do
    entry = Entry.create(user_id: '', room_id: @room.id)
    entry.valid?
    expect(entry.errors.full_messages).to include('Userを入力してください')
  end

  it 'ルーム情報がなければ、エントリーは登録できない' do
    entry = Entry.create(user_id: @user.id, room_id: '')
    entry.valid?
    expect(entry.errors.full_messages).to include('Roomを入力してください')
  end

  context 'ユーザーとルーム情報が入力されれば、' do
    before do
      @entry = Entry.create(user_id: @user.id, room_id: @room.id)
    end

    it 'エントリーは登録できる' do
      expect(@entry).to be_valid
    end

    it 'ただし、同じユーザーで同じルームに登録すると失敗する' do
      entry = Entry.create(user_id: @user.id, room_id: @room.id)
      entry.valid?
      expect(entry.errors.full_messages).to include('Userはすでに存在します')
    end
  end
end
