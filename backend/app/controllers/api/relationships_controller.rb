module Api
  class RelationshipsController < ApplicationController
    before_action :authenticate_user!, only: %w[create destroy]

    def create
      user = User.find(params[:followed_id])
      current_user.follow(user)

      render json: user, status: :ok
    end

    def destroy
      user = User.find(params[:id])
      current_user.unfollow(user)

      render json: user, status: :ok
    end
  end
end
