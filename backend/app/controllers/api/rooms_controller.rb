module Api
  class RoomsController < ApplicationController
    before_action :authenticate_user!, only: [:show, :create]

    def create
      room = Room.create
      Entry.create(room_id: room.id, user_id: current_user.id)
      Entry.create(room_id: room.id, user_id: params[:user_id])

      render json: room, status: :ok
    end

    def show
      room = Room.find(params[:id])
      if Entry.where(user_id: current_user.id, room_id: room.id).present?
        two_user = room.users
        messages = Message.search_for(current_user.id, room.id)

        render json: { joined_user: two_user, content: messages }, status: :ok
      else
        render plain: '正しいユーザーではありません', status: :bad_request
      end
    end
  end
end
