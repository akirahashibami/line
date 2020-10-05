class CreateRoomMedia < ActiveRecord::Migration[5.2]
  def change
    create_table :room_media do |t|
      t.integer   :user_id
      t.integer   :talk_room_id

      t.timestamps
    end
  end
end