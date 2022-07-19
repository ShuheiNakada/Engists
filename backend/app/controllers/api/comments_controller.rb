module Api
  class CommentsController < ApplicationController
    before_action :authenticate_user!, only: [:index, :create, :destroy]

    def index
      article = Article.find(params[:article_id])
      comments = Comment.search_for(article.id)

      render json: comments, status: :ok
    end

    def create
      comment = current_user.comments.new(comment_params)
      if comment.save
        render json: comment, status: :ok
      else
        render json: { errors: comment.errors.full_messages }, status: :bad_request
      end
    end

    def destroy
      comment = Comment.find_by(id: params[:id], user_id: current_user.id, article_id: params[:article_id]).destroy

      render json: comment, status: :ok
    end

    private

    def comment_params
      params.require(:comment).permit(:category, :title, :content).merge(article_id: params[:article_id])
    end
  end
end
