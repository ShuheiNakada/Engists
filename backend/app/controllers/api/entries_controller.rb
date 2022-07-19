module Api
  class EntriesController < ApplicationController
    before_action :authenticate_user!, only: [:index]

    def index
      entries = Entry.search_for(current_user.id)

      render json: entries, status: :ok
    end
  end
end
