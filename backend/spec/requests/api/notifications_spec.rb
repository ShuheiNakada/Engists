require 'rails_helper'

RSpec.describe 'Api::Notifications', type: :request do
  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:other_user)
    @room = Room.create
    @message = Message.create(
      user_id: @other_user.id,
      room_id: @room.id,
      content: 'はじめまして...'
    )
    @notification = Notification.create(
      visitor_id: @other_user.id,
      visited_id: @user.id,
      room_id: @room.id,
      message_id: @message.id,
      action: 'dm',
      checked: false
    )
  end

  describe 'GET /api/notifications' do
    it '有効なファクトリである' do
      expect(@user).to be_valid
    end

    it '通知情報を取得する' do
      user = { email: 't_develop@app.com', password: 'pass1234' }
      auth_tokens = sign_in(user)

      get api_notifications_path, headers: auth_tokens
      expect(response).to have_http_status :ok
    end
  end

  describe 'PUT /api/notifications/:id' do
    it '有効なテストデータである' do
      expect(@user).to be_valid
      expect(@other_user).to be_valid
      expect(@room).to be_valid
      expect(@message).to be_valid
      expect(@notification).to be_valid
    end

    it '通知情報を確認ステータスを更新する（未読 ⇔ 既読）' do
      user = { email: 't_develop@app.com', password: 'pass1234' }
      auth_tokens = sign_in(user)

      put api_notification_path(@notification.id), headers: auth_tokens
    end
  end
end
