module Api
  class ArticlesController < ApplicationController
    before_action :authenticate_user!, only: %w[index show]

    def index
      articles = Article.all
      articles_array = articles.map do |article|
        {
          user_id: article.user.id,
          name: article.user.name,
          email: article.user.email,
          id: article.id,
          title: article.title,
          content: article.content,
          created_at: article.created_at,
          tag_name: article.article_tags.map(&:tag_name).join(', ')
        }
      end

      render json: articles_array, status: :ok
    end

    def show
      article = Article.find(params[:id])
      article_object = {
        user_id: article.user.id,
        user_name: article.user.name,
        id: article.id,
        title: article.title,
        tag_name: article.article_tags.map(&:tag_name).join(', '),
        content: article.content,
        image_path: article.image.url,
        image_name: article.image_identifier,
        created_at: article.created_at,
        updated_at: article.updated_at
      }

      render json: article_object, status: :ok
    end

    def create
      article = Article.new(article_params)
      if article.save
        tag_list = params[:tag_name].split(' ')
        article.save_articles(tag_list)
        image = article.image.url
        render json: [article, image], status: :ok
      else
        render json: article.errors.full_messages, status: :bad_request
      end
    end

    def update
      article = Article.find(params[:id])
      if article.user.id == current_user.id && params[:title] != '' && params[:content] != ''
        article.update(article_params)
        tag_list = params[:tag_name].split(', ')
        article.save_articles(tag_list)
        render json: article, status: :ok
      else
        render status: :bad_request
      end
    end

    def my_articles
      articles = Article.where(user_id: current_user.id).order('updated_at DESC')
      my_articles_array = articles.map do |article|
        {
          id: article.id,
          title: article.title,
          content: article.content,
          image_path: article.image.url,
          created_at: article.created_at,
          updated_at: article.updated_at,
          tag_name: article.article_tags.map(&:tag_name).join(', ')
        }
      end

      render json: my_articles_array, status: :ok
    end

    def like_articles
      like_articles = current_user.like_articles
      like_articles_array = like_articles.map do |article|
        {
          id: article.id,
          title: article.title,
          tag_name: article.article_tags.map(&:tag_name).join(', '),
          content: article.content,
          image_path: article.image.url,
          created_at: article.created_at,
          updated_at: article.updated_at,
          user_name: article.user.name,
          user_id: article.user.id
        }
      end

      render json: like_articles_array, status: :ok
    end

    private

    def article_params
      params.require(:article).permit(:title, :content, :image).merge(user_id: current_user.id)
    end
  end
end
