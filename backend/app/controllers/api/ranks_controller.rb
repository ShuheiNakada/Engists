module Api
  class RanksController < ApplicationController
    def like_article_rank
      like_article_rank = Article.like_rank

      render json: like_article_rank, status: :ok
    end

    def follow_user_rank
      follow_user_rank = User.follow_rank

      render json: follow_user_rank, status: :ok
    end
  end
end
