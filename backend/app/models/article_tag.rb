class ArticleTag < ApplicationRecord
  has_many :article_tagmaps, dependent: :destroy
  has_many :articles, through: :article_tagmaps
end
