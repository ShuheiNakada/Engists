module Api
  class MessagesController < ApplicationController
    before_action :authenticate_user!, only: [:create]

    def create
      return if Entry.where(user_id: current_user.id, room_id: message_params[:room_id]).blank?

      message = current_user.messages.build(message_params)
      if message.save
        room = message.room
        room.create_notification_dm(current_user, message.id)
        render json: message, status: :ok
      else
        render json: message.errors.full_messages, status: :bad_request
      end
    end

    def destroy
      message = Message.find_by(id: params[:id], user_id: current_user.id, room_id: params[:room_id]).destroy

      render json: message, status: :ok
    end

    private

    def message_params
      params.require(:message).permit(:content, :room_id)
    end
  end
end
