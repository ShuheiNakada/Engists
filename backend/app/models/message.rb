class Message < ApplicationRecord
  has_many :notifications, dependent: :destroy
  belongs_to :user
  belongs_to :room

  validates :content, presence: true, length: { maximum: 500 }

  def self.search_for(_user_id, room_id)
    Message.where(room_id: room_id)
           .select(
             'messages.id', 'user_id', 'room_id', 'content', 'messages.created_at', 'messages.updated_at',
             'notifications.id AS notification_id', 'checked', 'action'
           )
           .left_joins(:notifications)
  end
end
