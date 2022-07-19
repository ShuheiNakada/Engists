class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :user_id, presence: true, uniqueness: { scope: :room_id }
  validates :room_id, presence: true, uniqueness: { scope: :user_id }

  def self.search_for(user_id)
    room_ids = Entry.where(user_id: user_id).pluck(:room_id)

    Entry
      .where(room_id: room_ids)
      .select(
        'user_id', 'room_id',
        'name', 'email'
      )
      .left_joins(:user)
  end
end
