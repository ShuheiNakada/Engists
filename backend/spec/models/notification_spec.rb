require 'rails_helper'

RSpec.describe Notification, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:other_user)
  end

  it '有効なファクトリである' do
    expect(@user).to be_valid
    expect(@other_user).to be_valid
  end

  it '訪問したユーザーのIDがなければ、無効である' do
    notification = Notification.create(visitor_id: '', visited_id: @other_user.id, room_id: 1, message_id: 1, action: 'dm', checked: false)
    notification.valid?
    expect(notification.errors.full_messages).to include('Visitorを入力してください')
  end

  it '訪問されたユーザーのIDがなければ、無効である' do
    notification = Notification.create(visitor_id: @user.id, visited_id: '', room_id: 1, message_id: 1, action: 'dm', checked: false)
    notification.valid?
    expect(notification.errors.full_messages).to include('Visitedを入力してください')
  end

  it '通知対象の入力がなければ、無効である' do
    notification = Notification.create(visitor_id: @user.id, visited_id: @other_user.id, room_id: 1, message_id: 1, action: '', checked: false)
    notification.valid?
    expect(notification.errors.full_messages).to include('Actionを入力してください')
  end

  it '通知チェックの有無に入力がなければ、無効である' do
    notification = Notification.create(visitor_id: @user.id, visited_id: @other_user.id, room_id: 1, message_id: 1, action: 'dm', checked: '')
    notification.valid?
    expect(notification.errors.full_messages).to include('Checkedは一覧にありません')
  end

  it '全て入力があれば、有効である' do
    notification = Notification.create(visitor_id: @user.id, visited_id: @other_user.id, room_id: 1, message_id: 1, action: 'dm', checked: false)
    notification.valid?
    expect(notification).to be_valid
  end

  it 'ルーム/メッセージIDはなくとも、有効である（いいね通知などを追加実装予定）' do
    notification = Notification.create(visitor_id: @user.id, visited_id: @other_user.id, room_id: '', message_id: '', action: 'dm', checked: false)
    notification.valid?
    expect(notification).to be_valid
  end
end
