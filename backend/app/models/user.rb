# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  mount_uploader :image, AvatarUploader

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_articles, through: :likes, source: :article
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy, inverse_of: :follower
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy, inverse_of: :followed
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_one :profile, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :rooms, dependent: :destroy, through: :entries
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy, inverse_of: :visitor
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy, inverse_of: :visited

  validates :name, presence: true, length: { maximum: 30 }

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def like(article)
    likes.find_or_create_by(article: article)
  end

  def unlike(article)
    like_articles.delete(article)
  end

  def self.search_for(category, word1, word2, word3, word4, sort)
    case category
    when 'basic_perfect'
      User
        .where(
          'status LIKE ? AND starting_age LIKE ? AND gender LIKE ? AND residence LIKE ?',
          "%#{word1}%", "%#{word2}%", "%#{word3}%", "%#{word4}%"
        )
        .select(
          'users.id', 'name', 'count(follower_id) AS follower_number', 'users.image',
          'status', 'starting_age', 'gender', 'residence', 'user_id',
          'users.created_at', 'users.updated_at'
        )
        .left_joins(:active_relationships, :profile)
        .group('users.id')
        .order(sort)
    when 'basic_partial'
      User
        .where(
          'status LIKE ? OR starting_age LIKE ? OR gender LIKE ? OR residence LIKE ?',
          "%#{word1}%", "%#{word2}%", "%#{word3}%", "%#{word4}%"
        )
        .select(
          'users.id', 'name', 'count(follower_id) AS follower_number', 'users.image',
          'status', 'starting_age', 'gender', 'residence', 'user_id',
          'users.created_at', 'users.updated_at'
        )
        .left_joins(:active_relationships, :profile)
        .group('users.id')
        .order(sort)
    end
  end

  def self.follow_rank
    User
      .select(
        'users.id', 'name', 'count(followed_id) AS follower_number', 'users.image',
        'status', 'birth', 'starting_age', 'gender', 'residence', 'user_id',
        'users.created_at', 'users.updated_at'
      )
      .left_joins(:passive_relationships, :profile)
      .group('users.id')
      .order('follower_number desc')
  end

  def self.profile
    User
      .select(
        'users.id', 'name',
        'status', 'starting_age', 'gender', 'residence', 'user_id',
        'users.created_at', 'users.updated_at'
      )
      .left_joins(:profile)
      .group('users.id')
      .order('created_at desc')
  end
end
