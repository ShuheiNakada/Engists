class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms, &:timestamps
  end
end
