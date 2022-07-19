require 'rails_helper'

RSpec.describe 'Api::Messages', type: :request do
  describe 'GET /api/messages' do
    before do
      @user = FactoryBot.create(:user)
      @other_user = FactoryBot.create(:other_user)
      @room = Room.create
      @my_entry = Entry.create(user_id: @user.id, room_id: @room.id)
      @partner_entry = Entry.create(user_id: @other_user.id, room_id: @room.id)
    end

    it '有効なテストデータである' do
      expect(@user).to be_valid
      expect(@other_user).to be_valid
      expect(@room).to be_valid
      expect(@my_entry).to be_valid
      expect(@partner_entry).to be_valid
    end

    it 'ルーム内でメッセージを送信する' do
      user = { email: 't_develop@app.com', password: 'pass1234' }
      auth_tokens = sign_in(user)
      params = {
        message: {
          room_id: @room.id,
          content: 'はじめまして...'
        }
      }

      post api_messages_path, params: params, headers: auth_tokens
      expect(response).to have_http_status :ok
    end
  end

  describe 'DELETE /api/messages/:id' do
    before do
      @user = FactoryBot.create(:user)
      @room = Room.create
      @message = Message.create(user_id: @user.id, room_id: @room.id, content: 'はじめまして...')
    end

    it '有効なテストデータである' do
      expect(@user).to be_valid
      expect(@room).to be_valid
      expect(@message).to be_valid
    end

    it 'メッセージを削除する' do
      user = { email: 't_develop@app.com', password: 'pass1234' }
      auth_tokens = sign_in(user)
      params = {
        room_id: @room.id
      }

      delete api_message_path(@message.id), params: params, headers: auth_tokens
      expect(response).to have_http_status :ok
    end
  end
end
