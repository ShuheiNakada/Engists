module Api
  class NotificationsController < ApplicationController
    before_action :authenticate_user!, only: [:index, :update, :all_read]

    def index
      notifications = Notification.search_for(current_user.id)

      render json: notifications, status: :ok
    end

    def update
      notification = Notification.find_by(id: params[:id], visited_id: current_user.id)
      if notification.checked == false
        notification.update(checked: true)
      else
        notification.update(checked: false)
      end

      render json: notification, status: :ok
    end

    def all_read
      notifications = Notification.where(id: params[:ids], visited_id: current_user.id)
      notifications.update(checked: true)

      render json: notifications, status: :ok
    end
  end
end
