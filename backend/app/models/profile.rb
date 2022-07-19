class Profile < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true, uniqueness: true
  validates :status, presence: true, length: { maximum: 5 }
  validates :starting_age, presence: true, length: { maximum: 6 }
  validates :birth, presence: true, length: { maximum: 10 }
  validates :gender, presence: true, length: { maximum: 2 }
  validates :residence, presence: true, length: { maximum: 4 }

  def self.search_for(category, word1, word2, word3, word4, sort)
    case category
    when 'basic_perfect'
      Profile.where(
        'status LIKE ? AND starting_age LIKE ? AND gender LIKE ? AND residence LIKE ?',
        "%#{word1}%", "%#{word2}%", "%#{word3}%", "%#{word4}%"
      )
             .select(
               'name',
               'profiles.id', 'status', 'starting_age', 'gender', 'residence', 'user_id',
               'users.created_at', 'users.updated_at'
             )
             .left_joins(:user)
             .order(sort)
    when 'basic_partial'
      Profile.where(
        'status LIKE ? OR starting_age LIKE ? OR gender LIKE ? OR residence LIKE ?',
        "%#{word1}%", "%#{word2}%", "%#{word3}%", "%#{word4}%"
      )
             .select(
               'name',
               'profiles.id', 'status', 'starting_age', 'gender', 'residence', 'user_id',
               'users.created_at', 'users.updated_at'
             )
             .left_joins(:user)
             .order(sort)
    else
      Profile.where(
        'status LIKE ? OR starting_age LIKE ? OR gender LIKE ? OR residence LIKE ?',
        "%#{word1}%", "%#{word2}%", "%#{word3}%", "%#{word4}%"
      )
             .select(
               'name',
               'profiles.id', 'status', 'starting_age', 'gender', 'residence', 'user_id',
               'users.created_at', 'users.updated_at'
             )
             .left_joins(:user)
             .order(sort)
    end
  end

  def self.job_changed
    Profile
      .where(status: '就職済み')
      .select(
        'users.id', 'name',
        'status', 'starting_age', 'gender', 'residence', 'user_id', 'profiles.updated_at'
      )
      .left_joins(:user)
      .group('profiles.id')
      .order('profiles.updated_at desc')
  end
end
