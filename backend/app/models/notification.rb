class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :room, optional: true
  belongs_to :message, optional: true
  belongs_to :visitor, class_name: 'User', optional: true
  belongs_to :visited, class_name: 'User', optional: true

  validates :visitor_id, presence: true
  validates :visited_id, presence: true
  validates :action, presence: true
  validates :checked, inclusion: { in: [true, false] }

  def self.search_for(user_id)
    Notification
      .where(visited_id: user_id)
      .select(
        'notifications.id', 'visitor_id', 'visited_id', 'room_id', 'message_id', 'action', 'checked', 'users.name', 'messages.content'
      )
      .left_joins(:visitor, :message)
  end
end
