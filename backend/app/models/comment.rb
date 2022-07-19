class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :category, presence: true, length: { maximum: 5 }
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true

  def self.search_for(article_id)
    Comment
      .where(article_id: article_id)
      .select(
        'comments.id', 'category', 'title', 'content',
        'users.id AS user_id', 'name AS user_name',
        'comments.created_at', 'comments.updated_at'
      )
      .left_joins(:user)
  end
end
