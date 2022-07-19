module Api
  class SearchesController < ApplicationController
    def index
      article_tags = ArticleTag.all

      render json: article_tags, status: :ok
    end

    def search
      model = params[:model]
      category = params[:category]
      word1 = params[:word1]
      if word1 == ''
        error_message = '検索ワードが入力されていません'
        render json: error_message, status: :bad_request
      else
        word2 = params[:word2]
        word3 = params[:word3]
        word4 = params[:word4]
        sort = params[:sort] || 'created_at DESC'
        sort = 'created_at DESC' if sort == 'initialValue'

        case model
        when 'profile'
          match_profiles = Profile.search_for(category, word1, word2, word3, word4, sort)
          results = match_profiles.map do |profile|
            image_path = { 'image_path' => profile.user.image.url }
            profile.attributes.merge!(image_path)
          end
        when 'article'
          match_articles = Article.search_for(category, word1, sort)
          results = match_articles.map do |article|
            image_path = { 'image_path' => article.image.url }
            tag_name = article.article_tags.pluck(:tag_name)
            tags = { 'tags' => tag_name }
            article.attributes.merge!(image_path, tags)
          end
        when 'user'
          match_users = User.search_for(category, word1, word2, word3, word4, sort)
          results = match_users.map do |user|
            image_path = { 'image_path' => user.image.url }
            user.attributes.merge!(image_path)
          end
        end
        render json: results, status: :ok
      end
    end
  end
end
