module Api
  class LikesController < ApplicationController
    before_action :authenticate_user!, only: [:create, :destroy, :likes]

    def create
      article = Article.find(params[:id])
      current_user.like(article)
      likes_count = article.likes.count

      render json: likes_count, status: :ok
    end

    def destroy
      article = Article.find(params[:id])
      current_user.unlike(article)
      likes_count = article.likes.count

      render json: likes_count, status: :ok
    end

    def likes
      already_liked_article_ids = current_user.like_articles.ids
      my_article_ids = current_user.articles.ids
      likes_count = Article.find(params[:id]).likes.count

      render json: {
        liked_ids: already_liked_article_ids,
        my_ids: my_article_ids,
        count: likes_count
      }, status: :ok
    end
  end
end
