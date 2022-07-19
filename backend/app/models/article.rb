class Article < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :article_tagmaps, dependent: :destroy
  has_many :article_tags, through: :article_tagmaps
  has_many :comments, dependent: :destroy

  mount_uploader :image, ImageUploader

  validates :title, presence: true, length: { maximum: 50 }, uniqueness: { scope: :user_id }
  validates :content, presence: true

  def save_articles(tag_list)
    current_tags = self.article_tags.pluck(:tag_name) unless self.article_tags.nil?
    old_tags = current_tags - tag_list
    new_tags = tag_list - current_tags

    old_tags.each do |old_name|
      self.article_tags.delete ArticleTag.find_by(tag_name: old_name)
    end

    new_tags.each do |new_name|
      article_tag = ArticleTag.find_or_create_by(tag_name: new_name)
      self.article_tags << article_tag
    end
  end

  def self.search_for(category, word1, sort)
    case category
    when 'title_or_content_or_tag'
      Article
        .where(
          'title LIKE ? OR content LIKE ? OR tag_name LIKE ?',
          "%#{word1}%", "%#{word1}%", "%#{word1}%"
        )
        .select(
          'articles.id', 'title', 'content', 'articles.image',
          'users.id AS user_id', 'name AS user_name',
          'count(distinct(likes.id)) AS like_number',
          'updated_at', 'created_at'
        )
        .left_joins(:user, :likes, :article_tags)
        .group('articles.id')
        .order(sort)
    when 'tag'
      ArticleTag.where(
        'tag_name LIKE ?',
        "%#{word3}%"
      ).order(sort)
    end
  end

  def self.like_rank
    Article
      .select(
        'articles.id', 'count(likes.id) AS like_number',
        'users.id AS user_id', 'users.name',
        'title', 'content', 'articles.image',
        'articles.updated_at', 'articles.created_at'
      )
      .left_joins(:likes, :user)
      .group('articles.id')
      .order('like_number desc')
  end
end
